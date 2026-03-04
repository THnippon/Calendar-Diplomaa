package com.example.calendarbackend.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ParticipantResponse {

    private Integer userId;
    private Integer statusId;

    public ParticipantResponse(Integer userId, Integer statusId)
    {
        this.userId = userId;
        this.statusId = statusId;
    }
}
