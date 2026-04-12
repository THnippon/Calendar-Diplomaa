package com.example.calendarbackend.service;

import com.example.calendarbackend.dto.LogoutRequest;
import com.example.calendarbackend.entity.RefreshTokenEntity;
import com.example.calendarbackend.entity.UserEntity;
import com.example.calendarbackend.repository.RefreshTokenRepository;
import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.OffsetDateTime;
import java.util.Base64;
import java.util.HexFormat;
import java.util.List;
import java.util.UUID;

@Service
public class RefreshTokenService {
    private final RefreshTokenRepository refreshTokenRepository;
    private final SecureRandom secureRandom;

    @Value("${jwt.refresh-token-expiration-seconds}")
    private long refreshTokenExpirationSeconds;

    @Transactional
    public String issueRefreshToken(UserEntity user)
    {
        String rawToken = generateRawToken();
        String tokenHash = hashRefreshToken(rawToken);
        UUID familyId = UUID.randomUUID();
        OffsetDateTime expiresAt = OffsetDateTime.now().plusSeconds(refreshTokenExpirationSeconds);

        RefreshTokenEntity refreshToken = new RefreshTokenEntity(
                user,
                tokenHash,
                familyId,
                expiresAt
        );
        refreshTokenRepository.save(refreshToken);
        return rawToken;
    }

    @Transactional
    public void logoutCurrentSession (String rawToken)
    {
        if (rawToken == null || rawToken.isBlank())
        {
            throw new IllegalArgumentException("Refresh token истёк");
        }
        String normalizedToken = rawToken.trim();
        String tokenHash = hashRefreshToken(normalizedToken);

        RefreshTokenEntity refreshToken = refreshTokenRepository.findByTokenHash(tokenHash).orElse(null);

        if (refreshToken == null)
        {
            return;
        }
        if(refreshToken.getRevokedAt() != null)
        {
            return;
        }
        refreshToken.setRevokedAt(OffsetDateTime.now());
        refreshToken.setRevokeReason("Logout");

    }

    public RefreshTokenEntity getValidRefreshToken (String rawToken)
    {
        String tokenHash = hashRefreshToken(rawToken);
        RefreshTokenEntity refreshToken = refreshTokenRepository.findByTokenHash(tokenHash).orElseThrow(() -> new IllegalArgumentException("Refresh token недействителен"));

        if (refreshToken.getRevokedAt() != null)
        {

            revokeAllFamily(refreshToken.getFamilyId(), OffsetDateTime.now(), "FAMILY_REVOKED_REUSED_TOKEN");
            throw new IllegalArgumentException("Refresh token уже отозван");
        }

        if (!refreshToken.getExpiresAt().isAfter(OffsetDateTime.now()))
        {
            throw new IllegalArgumentException("Refresh token истек");
        }
        return refreshToken;
    }

    private String generateRawToken()
    {
        byte[] randomBytes = new byte[32];
        secureRandom.nextBytes(randomBytes);
        return Base64.getUrlEncoder().encodeToString(randomBytes);
    }

    private String hashRefreshToken(String rawToken)
    {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = messageDigest.digest(rawToken.getBytes(StandardCharsets.UTF_8));
            return HexFormat.of().formatHex(hashBytes);
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("Алгоритм SHA-256 недоступен", e);
        }
    }

    public String rotate (RefreshTokenEntity currentToken)
    {
        String newToken = generateRawToken();
        String newTokenHash = hashRefreshToken(newToken);
        RefreshTokenEntity newRefreshToken = new RefreshTokenEntity(currentToken.getUser(), newTokenHash, currentToken.getFamilyId(), OffsetDateTime.now().plusSeconds(refreshTokenExpirationSeconds));
        RefreshTokenEntity savedNewRefreshToken = refreshTokenRepository.save(newRefreshToken);

        currentToken.setRevokedAt(OffsetDateTime.now());
        currentToken.setRevokeReason("ROTATED");
        currentToken.setReplacedByTokenId(savedNewRefreshToken.getId());

        refreshTokenRepository.save(currentToken);

        return newToken;
    }

    private void revokeAllFamily (UUID familyId, OffsetDateTime revokedAt, String revokeReason)
    {
        List<RefreshTokenEntity> familyTokens = refreshTokenRepository.findAllByFamilyId(familyId);

        for (RefreshTokenEntity familyToken : familyTokens)
        {
            if (familyToken.getRevokedAt() == null)
            {
                familyToken.setRevokedAt(revokedAt);
                familyToken.setRevokeReason(revokeReason);
            }

        }
        refreshTokenRepository.saveAll(familyTokens);
    }

    public void revokeAllUser(UserEntity user, OffsetDateTime revokedAt, String revokeReason)
    {
        List<RefreshTokenEntity> userTokens = refreshTokenRepository.findAllByUser_Id(user.getId());

        for (RefreshTokenEntity userToken : userTokens)
        {
            if (userToken.getRevokedAt() == null)
            {
                userToken.setRevokedAt(revokedAt);
                userToken.setRevokeReason(revokeReason);
            }
        }
        refreshTokenRepository.saveAll(userTokens);
    }

    public RefreshTokenService(RefreshTokenRepository refreshTokenRepository) {
        this.refreshTokenRepository = refreshTokenRepository;
        this.secureRandom = new SecureRandom();
    }


}
