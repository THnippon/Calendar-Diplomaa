package com.example.calendarbackend.dto;

import lombok.Getter;

import java.time.OffsetDateTime;
@Getter
public class EventResponse {
    private Integer id;
    private String title;
    private String description;
    private OffsetDateTime startAt;
    private OffsetDateTime endAt;
    private String address;
    private Integer createdBy;
    private String scopeCode;
    private Integer groupId;

    public EventResponse(Integer id, String title, String description, OffsetDateTime startAt, OffsetDateTime endAt, String address, Integer createdBy, String scopeCode, Integer groupId)
    {
        this.id = id;
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
