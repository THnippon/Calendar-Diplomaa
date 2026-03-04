package com.example.calendarbackend.model;

import lombok.Getter;

import java.time.OffsetDateTime;

@Getter
public class Event {
    private Integer id;
    private String title;
    private String description;
    private OffsetDateTime startAt;
    private OffsetDateTime endAt;
    private String address;
    private int createdBy;
    private String scopeCode;
    private Integer groupId;
    private OffsetDateTime createdAt;

    public Event(String title, String description, OffsetDateTime startAt, OffsetDateTime endAt, String address, int createdBy, String scopeCode, Integer groupId)
    {
        this.title = title;
        this.description = description;
        this.startAt = startAt;
        this.endAt = endAt;
        this.address = address;
        this.createdBy = createdBy;
        this.scopeCode = scopeCode;
        this.groupId = groupId;
    }

}
