package com.example.calendarbackend.controller;

import com.example.calendarbackend.dto.CreateEventRequest;
import com.example.calendarbackend.dto.CreateEventResponse;
import com.example.calendarbackend.dto.EventResponse;
import com.example.calendarbackend.entity.EventEntity;
import com.example.calendarbackend.service.EventService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping ("/events")
public class EventController {
    private final EventService eventService;

    public EventController(EventService eventService)
    {
        this.eventService = eventService;
    }

    @PostMapping
    public CreateEventResponse create(@RequestBody CreateEventRequest request)
    {
        EventEntity saved = eventService.create(request);
        return new CreateEventResponse(saved.getId());
    }
    @GetMapping ("/{id}")
    public EventResponse getById(@PathVariable Integer id)
    {
        EventEntity e = eventService.getById(id);
        return new EventResponse(e.getId(), e.getTitle(), e.getDescription(), e.getStartAt(), e.getEndAt(), e.getAddress(), e.getCreatedBy(), e.getScopeCode(), e.getGroupId());
    }
    @GetMapping ("/All")
    public List<EventResponse> getAll()
    {
        return eventService.getAll().stream().map(e -> new EventResponse(e.getId(), e.getTitle(), e.getDescription(), e.getStartAt(), e.getEndAt(), e.getAddress(), e.getCreatedBy(), e.getScopeCode(), e.getGroupId())).toList();
    }
}



