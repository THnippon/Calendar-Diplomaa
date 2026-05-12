package com.example.calendarbackend.repository;

import com.example.calendarbackend.entity.GroupMemberEntity;
import com.example.calendarbackend.entity.GroupMemberId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GroupMemberRepository extends JpaRepository<GroupMemberEntity, GroupMemberId> {

    List<GroupMemberEntity> findByGroup_Id(Integer groupId);

    boolean existsByGroup_IdAndUser_Id(Integer groupId, Integer userId);
}
