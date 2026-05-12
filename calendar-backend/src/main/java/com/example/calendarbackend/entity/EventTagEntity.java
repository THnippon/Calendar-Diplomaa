package com.example.calendarbackend.entity;


import jakarta.persistence.*;
import lombok.Getter;

@Entity
@Getter
@Table(name = "event_tags")
public class EventTagEntity {

    @EmbeddedId
    private EventTagId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("eventId")
    @JoinColumn(name = "event_id")
    private EventEntity event;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("tagId")
    @JoinColumn(name = "tag_id")
    private TagEntity tag;

    protected EventTagEntity() {}

    public EventTagEntity (EventEntity event, TagEntity tag) {
        this.event = event;
        this.tag = tag;
        this.id = new EventTagId(event.getId(), tag.getId());
    }
}
