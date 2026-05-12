package com.example.calendarbackend.repository;

import com.example.calendarbackend.entity.TagEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TagRepository extends JpaRepository<TagEntity, Integer> {
    boolean existsByName(String name);
}
