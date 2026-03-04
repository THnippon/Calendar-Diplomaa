package com.example.calendarbackend.dto;

import lombok.Getter;
import lombok.Setter;
import java.time.OffsetDateTime;

@Getter
@Setter
public class CreateEventRequest {
    private String title;
    private OffsetDateTime startAt;
    private OffsetDateTime endAt;
    private String scopeCode;
    private Integer groupId;
}
