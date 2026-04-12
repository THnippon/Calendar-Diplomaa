package com.example.calendarbackend.repository;

import com.example.calendarbackend.entity.RefreshTokenEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface RefreshTokenRepository extends JpaRepository<RefreshTokenEntity, Long> {
    Optional<RefreshTokenEntity> findByTokenHash(String tokenHash);

    List<RefreshTokenEntity> findAllByFamilyId(UUID familyId);

    List<RefreshTokenEntity> findAllByUser_Id(Integer userId);
}
