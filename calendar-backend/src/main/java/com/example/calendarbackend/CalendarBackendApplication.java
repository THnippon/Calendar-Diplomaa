package com.example.calendarbackend;

import com.example.calendarbackend.auth.jwt.JwtProperties;
import com.example.calendarbackend.entity.EventEntity;
import com.example.calendarbackend.repository.EventRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.time.OffsetDateTime;

@SpringBootApplication
@EnableConfigurationProperties(JwtProperties.class)
@EnableScheduling
public class CalendarBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(CalendarBackendApplication.class, args);
    }

}
