package com.example.calendarbackend.repository;

import com.example.calendarbackend.entity.EventEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.OffsetDateTime;
import java.util.List;

public interface EventRepository extends JpaRepository<EventEntity, Integer> {
    @Query("""
        select e from EventEntity e
        where e.startAt >= :rangeStart
        and e.startAt < :rangeEnd
        and exists(
                select 1
                from EventParticipantEntity ep
                               where ep.event = e
                                 and ep.user.id = :userId
                )
        order by e.startAt asc
               """)
    List<EventEntity> findAllInRangeAndParticipant(@Param("rangeStart") OffsetDateTime from, @Param("rangeEnd") OffsetDateTime to, @Param("userId") Integer userId);

    @Modifying
    @Query("""
            update EventEntity e
            set e.deletedAt = :archivedAt
            where e.endAt < :cutoff
            and e.deletedAt is null
               """)
    int archiveAllEndedBefore(@Param("cutoff") OffsetDateTime cutoff, @Param("archivedAt") OffsetDateTime archivedAt);
}