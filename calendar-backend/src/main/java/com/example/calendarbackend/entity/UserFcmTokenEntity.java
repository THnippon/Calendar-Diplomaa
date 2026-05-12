package com.example.calendarbackend.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.OffsetDateTime;

@Getter
@Entity
@Table(name = "user_fcm_tokens", uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "token"}))
public class UserFcmTokenEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_fcm_tokens_id_generator")
    @SequenceGenerator(name = "user_fcm_tokens_id_generator", sequenceName = "user_fcm_tokens_id_seq", allocationSize = 1)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;

    @Column(name = "token", nullable = false)
    private String token;

    @Column(name = "created_at", nullable = false)
    private OffsetDateTime createdAt;

    @Setter
    @Column(name = "last_seen_at", nullable = false)
    private OffsetDateTime lastSeenAt;


    public UserFcmTokenEntity(UserEntity user, String Token)
    {
        this.user = user;
        this.token = token;
    }
}
