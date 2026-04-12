package com.example.calendarbackend.scheduler;


import com.example.calendarbackend.service.EventService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.OffsetDateTime;
import java.time.ZoneOffset;

@Component
public class ExpiredEventsCleanupScheduler {
    public ExpiredEventsCleanupScheduler(EventService eventService)
    {
        this.eventService = eventService;
    }

    private final EventService eventService;

    @Scheduled(cron = "0 0 * * * *")
    public void deleteExpiredEvents()
    {
        eventService.deleteAllEndBefore(OffsetDateTime.now(ZoneOffset.UTC));
    }
}
