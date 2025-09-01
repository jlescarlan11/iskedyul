package com.iskedyul.iskedyul_backend.entities;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Courses {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    
    private String code;
    
    private String name;

    private Integer units;

    @Column(name="created_at", insertable=false, updatable=false)
    private LocalDate createdAt;
}
