package com.example.calendarbackend.entity;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "tags")
@Getter
public class TagEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "tags_id_generator")
    @SequenceGenerator(name = "tags_id_generator", sequenceName = "tags_id_seq", allocationSize = 1)
    private Integer id;

    @Setter
    @Column(name = "name", nullable = false, unique = true)
    private String name;

    @Setter
    @Column(name = "color", nullable = false)
    private String color;

    protected TagEntity() {}

    public TagEntity (String name, String color) {
        this.name = name;
        this.color = color;
    }

}
