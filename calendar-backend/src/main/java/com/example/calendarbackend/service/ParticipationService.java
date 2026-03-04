package com.example.calendarbackend.service;

import com.example.calendarbackend.dto.ParticipantResponse;
import com.example.calendarbackend.entity.*;
import com.example.calendarbackend.exception.NotFoundException;
import com.example.calendarbackend.repository.AttendanceStatusRepository;
import com.example.calendarbackend.repository.EventParticipantRepository;
import com.example.calendarbackend.repository.EventRepository;
import com.example.calendarbackend.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ParticipationService {
    private final EventParticipantRepository eventParticipantRepository;
    private final AttendanceStatusRepository attendanceStatusRepository;
    private final EventRepository eventRepository;
    private final UserRepository userRepository;

    public ParticipationService(EventParticipantRepository eventParticipantRepository, AttendanceStatusRepository attendanceStatusRepository, EventRepository eventRepository, UserRepository userRepository) {
        this.eventParticipantRepository = eventParticipantRepository;
        this.attendanceStatusRepository = attendanceStatusRepository;
        this.eventRepository = eventRepository;
        this.userRepository = userRepository;
    }

    @Transactional
    public void setStatus(Integer eventId, Integer userId, Integer statusId)
    {
        AttendanceStatusEntity a = attendanceStatusRepository.findById(statusId).orElseThrow(() -> new IllegalArgumentException("Неверный статус"));
        EventParticipantId id = new EventParticipantId(eventId, userId);
        var participantOpt = eventParticipantRepository.findById(id);
        EventParticipantEntity participant;
        if (participantOpt.isPresent())
        {
            participant = participantOpt.get();
        }
        else {
            EventEntity event = eventRepository.findById(eventId).orElseThrow(()-> new IllegalArgumentException("Событие " + eventId + " не найдено"));
            UserEntity user = userRepository.findById(userId).orElseThrow(() -> new IllegalArgumentException("Пользователь " + userId + " не найден"));
            participant = new EventParticipantEntity(event, user);
        }
        participant.changeStatus(a);
        eventParticipantRepository.save(participant);
    }

    @Transactional
    public List<ParticipantResponse> listParticipants(Integer eventId)
    {
        if (!eventRepository.existsById(eventId))
        {
            throw new NotFoundException("Событие не найдено");
        }
        return eventParticipantRepository.findByEvent_Id(eventId).stream().map(p -> new ParticipantResponse(p.getUser().getId(), p.getStatus().getId())).toList();
    }

    @Transactional
    public ParticipantResponse getParticipant(Integer eventId, Integer participantId)
    {
        EventParticipantId id = new EventParticipantId(eventId, participantId);
        EventParticipantEntity p = eventParticipantRepository.findById(id).orElseThrow(() -> new NotFoundException("Участник не найден!" + participantId));
        return new ParticipantResponse(p.getUser().getId(), p.getStatus().getId());
    }
}
