package com.example.calendarbackend.service;


import com.example.calendarbackend.entity.EventEntity;
import com.example.calendarbackend.entity.EventTagEntity;
import com.example.calendarbackend.entity.TagEntity;
import com.example.calendarbackend.exception.NotFoundException;
import com.example.calendarbackend.repository.EventRepository;
import com.example.calendarbackend.repository.EventTagRepository;
import com.example.calendarbackend.repository.TagRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.nio.file.AccessDeniedException;
import java.util.List;

@Service
public class TagService {

    private final TagRepository tagRepository;
    private final EventTagRepository eventTagRepository;
    private final EventRepository eventRepository;


    public TagService(TagRepository tagRepository, EventTagRepository eventTagRepository, EventRepository eventRepository) {
        this.tagRepository = tagRepository;
        this.eventTagRepository = eventTagRepository;
        this.eventRepository = eventRepository;
    }

    @Transactional
    public void assignToEvent(Integer eventId, Integer tagId, Integer requesterId) throws AccessDeniedException {
        EventEntity event = eventRepository.findById(eventId)
                .orElseThrow(() -> new NotFoundException("Событие не найдено"));

        if (!event.getCreatedBy().equals(requesterId)) {
            throw new AccessDeniedException("Только создатель события может назначать теги");
        }

        if (eventTagRepository.existsByEvent_IdAndTag_Id(eventId, tagId)) {
            throw new IllegalArgumentException("Тег уже назначет этому событию");
        }

        TagEntity tag = tagRepository.findById(tagId)
                .orElseThrow(() -> new NotFoundException("Такой тег не найден"));

        eventTagRepository.save(new EventTagEntity(event, tag));
    }

    public List<TagEntity> getByEventId(Integer eventId) {
        return eventTagRepository.findByEvent_Id(eventId)
                .stream()
                .map(EventTagEntity::getTag)
                .toList();
    }
}
