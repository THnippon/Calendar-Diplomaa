package com.example.calendarbackend.service;

import com.example.calendarbackend.entity.UserEntity;
import com.example.calendarbackend.entity.UserFcmTokenEntity;
import com.example.calendarbackend.exception.NotFoundException;
import com.example.calendarbackend.repository.UserFcmTokenRepository;
import com.example.calendarbackend.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.time.ZoneOffset;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final UserFcmTokenRepository userFcmTokenRepository;

    @Transactional
    public void registerFcmToken(Integer userId, String token)
    {
        if (token == null || token.isEmpty())
        {
            throw new IllegalArgumentException("FCM-токен не может быть пустым");
        }

        OffsetDateTime now = OffsetDateTime.now(ZoneOffset.UTC);

        userFcmTokenRepository.findByUserIdAndToken(userId, token)
                .ifPresentOrElse(
                        existing -> existing.setLastSeenAt(now),
                        () -> {
                            UserEntity user = userRepository.findById(userId).orElseThrow(
                                    () -> new NotFoundException("Пользователь не найден")
                            );
                                    UserFcmTokenEntity newToken = new UserFcmTokenEntity(user, token);
                                    userFcmTokenRepository.save(newToken);
                        }
                );
    }

    public UserService(UserRepository userRepository, UserFcmTokenRepository userFcmTokenRepository) {
        this.userRepository = userRepository;
        this.userFcmTokenRepository = userFcmTokenRepository;
    }
}
