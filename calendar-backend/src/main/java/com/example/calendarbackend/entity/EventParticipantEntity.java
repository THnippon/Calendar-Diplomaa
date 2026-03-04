package com.example.calendarbackend.entity;

import jakarta.persistence.*;
import lombok.Getter;




@Getter
@Entity
@Table(name = "event_participants")
public class EventParticipantEntity {

    @EmbeddedId
    private EventParticipantId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("eventId")
    @JoinColumn(name = "event_id")
    private EventEntity event;
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("userId")
    @JoinColumn(name = "user_id")
    private UserEntity user;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "status_id")
    private AttendanceStatusEntity status;

    protected EventParticipantEntity() {}

    public EventParticipantEntity(EventEntity event, UserEntity user)
    {
        this.event = event;
        this.user = user;
        this.id = new EventParticipantId(event.getId(), user.getId());
    }

    public EventParticipantEntity(EventEntity event, UserEntity user, AttendanceStatusEntity status)
    {
        this.event = event;
        this.user = user;
        this.id = new EventParticipantId(event.getId(), user.getId());
        this.status = status;
    }

    public void changeStatus(AttendanceStatusEntity status)
    {
        this.status = status;
    }
}
