package com.example.calendarbackend.repository;

import com.example.calendarbackend.entity.UserFcmTokenEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserFcmTokenRepository extends JpaRepository<UserFcmTokenEntity, Integer> {
    Optional<UserFcmTokenEntity> findByUserIdAndToken(Integer userId, String token);
}
