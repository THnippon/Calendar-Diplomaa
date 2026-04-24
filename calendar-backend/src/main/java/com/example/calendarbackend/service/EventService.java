package com.example.calendarbackend.service;

import com.example.calendarbackend.dto.CreateEventRequest;
import com.example.calendarbackend.entity.EventEntity;
import com.example.calendarbackend.entity.UserEntity;
import com.example.calendarbackend.exception.NotFoundException;
import com.example.calendarbackend.repository.EventRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import javax.swing.event.InternalFrameEvent;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.List;

@Service
public class EventService {
    private final EventRepository eventRepository;

    public EventService(EventRepository eventRepository) {
        this.eventRepository = eventRepository;
    }

    public EventEntity create(CreateEventRequest request, Integer userId)
    {
        validate(request);
        EventEntity e = new EventEntity(request.getTitle(), request.getStartAt(), request.getEndAt(), userId, request.getScopeCode(), request.getGroupId()); //Поменять createdBy
        eventRepository.save(e);
        return e;
    }

    private void validate(CreateEventRequest e)
    {

        if (!("INVITE_ONLY".equals(e.getScopeCode()) || "GROUP".equals(e.getScopeCode())))
        {
            throw new IllegalArgumentException("Код должен быть INVITE_ONLY или GROUP, а имеет значение " + e.getScopeCode());
        }
        if ("INVITE_ONLY".equals(e.getScopeCode()) && e.getGroupId() != null)
        {
            throw new IllegalArgumentException("Код " + e.getScopeCode() + " поле groupId должно быть null, а имеет значение " + e.getGroupId());

        } else if ("GROUP".equals(e.getScopeCode()) && e.getGroupId() == null)
        {
            throw new IllegalArgumentException("Код " + e.getScopeCode() + " поле groupId не должно быть null");
        }
        if (e.getEndAt().isBefore(e.getStartAt()) || e.getEndAt().isEqual(e.getStartAt()))
        {
            throw new IllegalArgumentException("Событие должно начинаться раньше чем это событие заканчивается");
        }
    }
    public EventEntity getById(Integer id)
    {
        return eventRepository.findById(id).orElseThrow(() -> new NotFoundException("Событие не найдено"));
    }
    public List<EventEntity> getAll() {
        return eventRepository.findAll();
    }

    public List<EventEntity> getInRangeAndParticipant(OffsetDateTime from, OffsetDateTime to, Integer userId)
    {
        if (from == null || to == null)
        {
            throw new IllegalArgumentException("Параметры from и to обязательны");
        }
        if (!from.isBefore(to))
        {
            throw new IllegalArgumentException("Параметр from должен быть раньше чем параметр to");
        }
        return eventRepository.findAllInRangeAndParticipant(from, to, userId);
    }

    @Transactional
    public int archiveAllEndBefore(OffsetDateTime cutoff)
    {
        if (cutoff == null)
        {
            throw new IllegalArgumentException("Параметр cutoff обязательно передавать");
        }
        OffsetDateTime now = OffsetDateTime.now(ZoneOffset.UTC);
        return eventRepository.archiveAllEndedBefore(cutoff, now);
    }
}
