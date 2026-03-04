package com.example.calendarbackend.repository;

import com.example.calendarbackend.entity.EventEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventRepository extends JpaRepository<EventEntity, Integer> {
}