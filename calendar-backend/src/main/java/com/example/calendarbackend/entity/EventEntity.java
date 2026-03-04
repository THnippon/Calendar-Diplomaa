package com.example.calendarbackend.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.OffsetDateTime;

@Entity
@Table(name="events")
@Getter
public class EventEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "events_id_generator")
    @SequenceGenerator(name = "events_id_generator", sequenceName = "events_id_seq", allocationSize = 1)
    private Integer id;
    @Setter
    @Column(name = "title")
    private String title;
    @Setter
    @Column(name = "start_at")
    private OffsetDateTime startAt;
    @Setter
    @Column(name = "end_at")
    private OffsetDateTime endAt;
    @Column(name = "created_at", insertable = false, updatable = false)
    private OffsetDateTime createdAt;
    @Setter
    @Column(name = "scope_code")
    private String scopeCode;
    @Setter
    @Column(name = "group_id")
    private Integer groupId;
    @Setter
    @Column(name = "created_by")
    private Integer createdBy;
    @Setter
    @Column(name = "description")
    private String description;
    @Setter
    @Column(name = "address")
    private String address;


    protected EventEntity() {}
    public EventEntity(String title,
                       OffsetDateTime startAt,
                       OffsetDateTime endAt,
                       Integer createdBy,
                       String scopeCode,
                       Integer groupId) {
        this.title = title;
        this.startAt = startAt;
        this.endAt = endAt;
        this.createdBy = createdBy;
        this.scopeCode = scopeCode;
        this.groupId = groupId;

    }

}
