package com.example.calendarbackend.repository;

import com.example.calendarbackend.entity.EventTagEntity;
import com.example.calendarbackend.entity.EventTagId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EventTagRepository extends JpaRepository<EventTagEntity, EventTagId> {

    List<EventTagEntity> findByEvent_Id(Integer eventId);

    boolean existsByEvent_IdAndTag_Id(Integer eventId, Integer tagId);
}
