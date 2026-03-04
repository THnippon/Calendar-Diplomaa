package com.example.calendarbackend;

import com.example.calendarbackend.entity.EventEntity;
import com.example.calendarbackend.repository.EventRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.time.OffsetDateTime;

@SpringBootApplication
public class CalendarBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(CalendarBackendApplication.class, args);
    }
    @Bean
    CommandLineRunner testInsert(EventRepository eventRepository)
    {
        return args -> {
            EventEntity event = new EventEntity(
                    "Встреча по диплому",
                    OffsetDateTime.parse("2026-01-10T18:00:00+05:00"),
                    OffsetDateTime.parse("2026-01-10T19:00:00+05:00"),
                    1,
                    "INVITE_ONLY",
                    null
            );
            eventRepository.save(event);
        };

    }
}
