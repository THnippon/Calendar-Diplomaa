package com.example.calendarbackend.service;

import com.example.calendarbackend.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserRepository userRepository;

    @Transactional

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
}
