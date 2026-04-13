package com.example.calendarbackend.controller;

import com.example.calendarbackend.dto.CreateEventRequest;
import com.example.calendarbackend.dto.CreateEventResponse;
import com.example.calendarbackend.dto.EventResponse;
import com.example.calendarbackend.entity.EventEntity;
import com.example.calendarbackend.entity.UserEntity;
import com.example.calendarbackend.mapper.EventMapper;
import com.example.calendarbackend.model.Event;
import com.example.calendarbackend.service.EventService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.OffsetDateTime;
import java.util.List;

@RestController
@RequestMapping ("/events")
public class EventController {
    private final EventService eventService;
    private final EventMapper eventMapper;

    public EventController(EventService eventService, EventMapper eventMapper)
    {
        this.eventService = eventService;
        this.eventMapper = eventMapper;
    }


    @PostMapping
    public CreateEventResponse create(@RequestBody CreateEventRequest request, @AuthenticationPrincipal UserEntity user)
    {
        EventEntity saved = eventService.create(request, user.getId());
        return new CreateEventResponse(saved.getId());
    }
    @GetMapping ("/{id}")
    public EventResponse getById(@PathVariable Integer id)
    {
        EventEntity e = eventService.getById(id);
        return eventMapper.toResponse(e);
    }

    @GetMapping
    public List<EventResponse> getAllInRangeAndParticipant(@RequestParam OffsetDateTime from, @RequestParam OffsetDateTime to, @AuthenticationPrincipal UserEntity user)
    {
        return eventService.getInRangeAndParticipant(from, to, user.getId()).stream().map(eventMapper::toResponse).toList();
    }
}



