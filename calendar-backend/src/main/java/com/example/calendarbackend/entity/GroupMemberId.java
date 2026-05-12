package com.example.calendarbackend.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class GroupMemberId implements Serializable {

    @Column(name = "group_id")
    private Integer groupId;

    @Column(name = "user_id")
    private Integer userId;

    protected GroupMemberId() {}

    public GroupMemberId(Integer groupId, Integer userId){
        this.groupId = groupId;
        this.userId = userId;
    }
}
