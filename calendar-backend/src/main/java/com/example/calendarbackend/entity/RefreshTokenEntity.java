package com.example.calendarbackend.entity;

import jakarta.persistence.*;
import lombok.Generated;
import lombok.Getter;
import lombok.Setter;

import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name="refresh_tokens")
@Getter
public class RefreshTokenEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "refresh_tokens_id_generator")
    @SequenceGenerator(name = "refresh_tokens_id_generator", sequenceName = "refresh_tokens_id_seq", allocationSize = 1)
    private Long id;

    @ManyToOne(fetch =FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private  UserEntity user;

    @Column(name = "token_hash", nullable = false, unique = true)
    private String tokenHash;

    @Column(name = "family_id", nullable = false)
    private UUID familyId;

    @Column(name="created_at", nullable = false, insertable = false, updatable = false)
    private OffsetDateTime createdAt;

    @Column(name="expires_at", nullable = false)
    private OffsetDateTime expiresAt;

    @Setter
    @Column(name="revoked_at")
    private OffsetDateTime revokedAt;

    @Setter
    @Column(name="revoke_reason")
    private String revokeReason;

    @Setter
    @Column(name = "replaced_by_token_id")
    private Long replacedByTokenId;

    protected RefreshTokenEntity(){}
    public RefreshTokenEntity(UserEntity user, String tokenHash, UUID familyId, OffsetDateTime expiresAt)
    {
        this.user = user;
        this.tokenHash = tokenHash;
        this.familyId = familyId;
        this.expiresAt = expiresAt;
    }
}
