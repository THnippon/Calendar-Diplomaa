package com.example.calendarbackend.dto;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CreateEventResponse {
    private Integer id;

    public CreateEventResponse(Integer id)
    {
        this.id = id;
    }
}
