package com.example.calendarbackend.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.OffsetDateTime;

@Entity
@Table(name = "groups")
@Getter
public class GroupEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "groups_id_generator")
    @SequenceGenerator(name = "groups_id_generator", sequenceName = "groups_id_seq", allocationSize = 1)
    private Integer id;

    @Setter
    @Column(name = "name", nullable = false)
    private String name;

    @Setter
    @Column(name = "description", nullable = false)
    private String description;

    @Column(name = "created_by", nullable = false)
    private Integer createdBy;

    @Setter
    @Column(name = "avatar_url", nullable = true)
    private String avatarUrl;

    @Column(name = "created_at", nullable = false)
    private OffsetDateTime createdAt;

    @Setter
    @Column(name = "invite_code", unique = true)
    private String inviteCode;

    protected GroupEntity() {}

    public GroupEntity(String name, String description, Integer createdBy)
    {
        this.name = name;
        this.description = description;
        this.createdBy = createdBy;
    }
}
