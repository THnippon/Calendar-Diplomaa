package com.example.calendarbackend.service;


import com.example.calendarbackend.entity.GroupEntity;
import com.example.calendarbackend.exception.NotFoundException;
import com.example.calendarbackend.repository.GroupMemberRepository;
import com.example.calendarbackend.repository.GroupRepository;
import com.example.calendarbackend.repository.RoleRepository;
import com.example.calendarbackend.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.nio.file.AccessDeniedException;
import java.util.UUID;

@Service
public class GroupService {

    private final GroupRepository groupRepository;
    private final GroupMemberRepository groupMemberRepository;
    private final RoleRepository roleRepository;
    private final UserRepository userRepository;


    public GroupService(GroupRepository groupRepository, GroupMemberRepository groupMemberRepository, RoleRepository roleRepository, UserRepository userRepository) {
        this.groupRepository = groupRepository;
        this.groupMemberRepository = groupMemberRepository;
        this.roleRepository = roleRepository;
        this.userRepository = userRepository;
    }

    @Transactional
    public String generateInviteCode(Integer groupId, Integer requesterId) throws AccessDeniedException {
        GroupEntity group = groupRepository.findById(groupId)
                .orElseThrow(() -> new NotFoundException("Группа не найдена"));

        if (!group.getCreatedBy().equals(requesterId))
        {
            throw new AccessDeniedException("Только созадтель группы может обновить код приглашения");
        }

        String code = UUID.randomUUID()
                .toString()
                .replace("-", "")
                .substring(0, 10)
                .toUpperCase();

        group.setInviteCode(code);
        return code;
    }
}
