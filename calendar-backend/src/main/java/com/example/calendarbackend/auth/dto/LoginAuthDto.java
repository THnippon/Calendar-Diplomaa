package com.example.calendarbackend.auth.dto;

import lombok.Getter;
@Getter
public class LoginAuthDto {



    private int id;
    private String email;
    private String nickname;


    public LoginAuthDto(int id, String email, String nickname)
    {
        this.id = id;
        this.email = email;
        this.nickname = nickname;
    }
}
