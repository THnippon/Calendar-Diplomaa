package com.example.calendarbackend.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.OffsetDateTime;

@Getter
@Entity
@Table(name = "users")
public class UserEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "users_id_generator")
    @SequenceGenerator(name = "users_id_generator", sequenceName = "users_id_seq", allocationSize = 1)
    private Integer id;
    @Setter
    @Column(name = "email", nullable = false, unique = true)
    private String email;
    @Setter
    @Column(name = "password_hash", nullable = false)
    private String passwordHash;
    @Setter
    @Column(name = "nickname", nullable = false)
    private String nickname;
    @Setter
    @Column(name = "bio")
    private String bio;
    @Setter
    @Column(name = "avatar_url")
    private String avatarUrl;
    @Column(name = "created_at", nullable = false, insertable = false, updatable = false)
    private OffsetDateTime createdAt;

    protected UserEntity() {}

    public UserEntity (String email,
                       String passwordHash,
                       String nickname)
    {
        this.email = email;
        this.passwordHash = passwordHash;
        this.nickname = nickname;
    }


}
