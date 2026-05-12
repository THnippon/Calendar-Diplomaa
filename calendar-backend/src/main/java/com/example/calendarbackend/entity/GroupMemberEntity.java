package com.example.calendarbackend.entity;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Fetch;


@Getter
@Entity
@Table(name = "group_members")
public class GroupMemberEntity {

    @EmbeddedId
    private GroupMemberId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("groupId")
    @JoinColumn(name = "group_id")
    private GroupEntity group;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("userId")
    @JoinColumn(name = "user_id")
    private UserEntity user;

    @Setter
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "role_id")
    private RoleEntity role;

    protected GroupMemberEntity() {}

    public GroupMemberEntity(GroupEntity group, UserEntity user, RoleEntity role) {
        this.group = group;
        this.user = user;
        this.role = role;
        this.id = new GroupMemberId(group.getId(), user.getId());
    }
}
