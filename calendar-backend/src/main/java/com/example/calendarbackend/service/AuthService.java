package com.example.calendarbackend.service;

import com.example.calendarbackend.auth.dto.LoginAuthDto;
import com.example.calendarbackend.auth.jwt.JwtService;
import com.example.calendarbackend.dto.*;
import com.example.calendarbackend.entity.RefreshTokenEntity;
import com.example.calendarbackend.entity.UserEntity;
import com.example.calendarbackend.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final RefreshTokenService refreshTokenService;

    @Transactional
    public LoginResponse register(RegisterRequest request)
    {
        String email = request.getEmail().trim().toLowerCase();
        String password = request.getPassword();
        String nickname = request.getNickname();
        if (userRepository.existsByEmail(email))
        {
            throw new IllegalArgumentException("Пользователь с данным email уже существует");
        }

        String passwordHash = passwordEncoder.encode(password);

        UserEntity user = new UserEntity(email, passwordHash, nickname);
        UserEntity savedUser = userRepository.save(user);
        String accessToken = jwtService.generateAccessToken(savedUser);
        String refreshToken = refreshTokenService.issueRefreshToken(savedUser);
        return new LoginResponse(
                accessToken,
                "Bearer",
                refreshToken,
                new LoginAuthDto(
                        savedUser.getId(),
                        savedUser.getEmail(),
                        savedUser.getNickname()
                )
        );
    }


    @Transactional
    public LoginResponse login(LoginRequest request)
    {
        String email = request.getEmail().trim().toLowerCase();
        String password = request.getPassword();
        UserEntity user = userRepository.findByEmail(email).orElseThrow(() -> new IllegalArgumentException(
                "Неверный email или пароль"
                )
        );
        if (!passwordEncoder.matches(password, user.getPasswordHash()))
        {
            throw new IllegalArgumentException("Неверный email или пароль");
        }
        String accessToken = jwtService.generateAccessToken(user);
        String refreshToken = refreshTokenService.issueRefreshToken(user);
        return new LoginResponse(
                accessToken,
                "Bearer",
                refreshToken,
                new LoginAuthDto(
                        user.getId(),
                        user.getEmail(),
                        user.getNickname()));
    }

    
    @Transactional
    public void logout(String rawToken)
    {
        refreshTokenService.logoutCurrentSession(rawToken);
    }

    @Transactional
    public LoginResponse refresh (String rawToken)
    {
        if (rawToken == null || rawToken.isBlank())
        {
            throw new IllegalArgumentException("Refresh token истёк");
        }

        String normalizedToken = rawToken.trim();
        RefreshTokenEntity refreshToken = refreshTokenService.getValidRefreshToken(normalizedToken);

        String newRefreshToken = refreshTokenService.rotate(refreshToken);

        UserEntity user = refreshToken.getUser();

        String newAccessToken = jwtService.generateAccessToken(user);

        return new LoginResponse(newAccessToken, "Bearer", newRefreshToken, new LoginAuthDto(user.getId(), user.getEmail(), user.getNickname())
        );
    }


    public AuthService(UserRepository userRepository, PasswordEncoder passwordEncoder, JwtService jwtService, RefreshTokenService refreshTokenService) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
        this.refreshTokenService = refreshTokenService;
    }
}
