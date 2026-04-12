package com.example.calendarbackend.controller;

import com.example.calendarbackend.dto.*;
import com.example.calendarbackend.service.AuthService;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/register")
    public LoginResponse register (@Valid @RequestBody RegisterRequest request)
    {
        return authService.register(request);
    }

    @PostMapping("/login")
    public LoginResponse login (@Valid @RequestBody LoginRequest request)
    {
        return authService.login(request);
    }

    @PostMapping("/logout")
    public void logout (@Valid @RequestBody LogoutRequest request) { authService.logout(request.getRefreshToken()); }

    @PostMapping("/refresh")
    public LoginResponse refresh (@Valid @RequestBody RefreshRequest request) {return authService.refresh(request.getRefreshToken()); }
}
