package com.example.calendarbackend.dto;

import com.example.calendarbackend.auth.dto.LoginAuthDto;
import lombok.Getter;

@Getter
public class LoginResponse {

    private String accessToken;
    private String tokenType;
    private String refreshToken;
    private LoginAuthDto user;


    public LoginResponse(String accessToken, String tokenType, String refreshToken, LoginAuthDto user)
    {
        this.accessToken = accessToken;
        this.tokenType = tokenType;
        this.refreshToken = refreshToken;
        this.user = user;
    }
}
