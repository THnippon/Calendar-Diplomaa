package com.example.calendarbackend.controller;

import com.example.calendarbackend.dto.ParticipantResponse;
import com.example.calendarbackend.dto.SetParticipantStatusRequest;
import com.example.calendarbackend.service.ParticipationService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ParticipationController {

    private final ParticipationService participationService;


    public ParticipationController(ParticipationService participationService) {this.participationService = participationService;}

    @PutMapping("/events/{eventId}/participants/{userId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void setStatus (@PathVariable Integer eventId, @PathVariable Integer userId, @RequestBody SetParticipantStatusRequest request)
    {
        participationService.setStatus(eventId, userId, request.getStatusId());
    }

    @GetMapping("/events/{eventId}/participants")
    public List<ParticipantResponse> list(@PathVariable Integer eventId)
    {
        return participationService.listParticipants(eventId);
    }

    @GetMapping("/events/{eventId}/participants/{participantId}")
    public ParticipantResponse getParticipant(@PathVariable Integer eventId, @PathVariable Integer participantId)
    {
        return participationService.getParticipant(eventId, participantId);
    }
}
