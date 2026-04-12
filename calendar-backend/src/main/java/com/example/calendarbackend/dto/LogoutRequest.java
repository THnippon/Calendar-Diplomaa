package com.example.calendarbackend.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class LogoutRequest {
    @NotBlank
    private String refreshToken;

    public LogoutRequest ()
    {}
}
