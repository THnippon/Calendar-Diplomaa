package com.example.calendarbackend.repository;

import com.example.calendarbackend.entity.EventParticipantEntity;
import com.example.calendarbackend.entity.EventParticipantId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EventParticipantRepository extends JpaRepository<EventParticipantEntity, EventParticipantId> {
    List<EventParticipantEntity> findByEvent_Id(Integer eventId);
}
