package com.example.calendarbackend.entity;


import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class EventTagId implements Serializable {

    @Column(name = "event_id")
    private Integer eventId;

    @Column(name = "tag_id")
    private Integer tagId;

    protected EventTagId() {}

    public EventTagId (Integer eventId, Integer tagId) {
        this.eventId = eventId;
        this.tagId = tagId;
    }
}
