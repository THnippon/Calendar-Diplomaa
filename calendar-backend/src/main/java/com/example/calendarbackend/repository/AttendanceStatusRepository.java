package com.example.calendarbackend.repository;

import com.example.calendarbackend.entity.AttendanceStatusEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AttendanceStatusRepository extends JpaRepository<AttendanceStatusEntity, Integer> {
}
