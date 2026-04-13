package com.example.calendarbackend.mapper;

import com.example.calendarbackend.dto.EventResponse;
import com.example.calendarbackend.entity.EventEntity;
import com.example.calendarbackend.repository.EventRepository;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper (componentModel = MappingConstants.ComponentModel.SPRING)
public interface EventMapper {

    EventResponse toResponse (EventEntity entity);
}
