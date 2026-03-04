package com.example.calendarbackend.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class EventParticipantId implements Serializable {
    @Column(name = "event_id")
    private Integer eventId;


    @Column(name = "user_id")
    private Integer userId;


    protected EventParticipantId() {}
    public EventParticipantId(Integer eventId, Integer userId)
    {
        this.eventId = eventId;
        this.userId = userId;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        EventParticipantId that = (EventParticipantId) o;
        return Objects.equals(eventId, that.eventId) && Objects.equals(userId, that.userId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(eventId, userId);
    }
}
