package com.example.calendarbackend.auth.jwt;

import com.example.calendarbackend.entity.UserEntity;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.OffsetDateTime;
import java.util.Date;

@Service
public class JwtService {

    private final JwtProperties jwtProperties;

    private SecretKey secretKey;

    public JwtService(JwtProperties jwtProperties) {
        this.jwtProperties = jwtProperties;
    }

    @PostConstruct
    public void init()
    {
        byte[] keyBytes = Decoders.BASE64.decode(jwtProperties.getSecretBase64());
        this.secretKey = Keys.hmacShaKeyFor(keyBytes);

    }

    public String generateAccessToken(UserEntity user)
    {
        Instant now = Instant.now();
        Instant expiresAt = now.plusSeconds(jwtProperties.getAccessTokenExpirationSeconds());

        return Jwts.builder()
                .subject(user.getId().toString())
                .issuer(jwtProperties.getIssuer())
                .issuedAt(Date.from(now))
                .expiration(Date.from(expiresAt))
                .signWith(secretKey)
                .compact();
    }

    public String extractSubject(String token)
    {
        return extractAllClaims(token).getSubject();
    }

    public boolean isAccessTokenValid(String token, UserEntity user)
    {
        String subject = extractSubject(token);
        return subject != null && !isTokenExpired(token) && subject.equals(user.getId().toString());
    }

    private boolean isTokenExpired(String token)
    {
        Date expiration = extractAllClaims(token).getExpiration();
        return expiration.before(new Date());
    }

    private Claims extractAllClaims (String token)
    {
        return Jwts.parser()
                .verifyWith(secretKey)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

}
