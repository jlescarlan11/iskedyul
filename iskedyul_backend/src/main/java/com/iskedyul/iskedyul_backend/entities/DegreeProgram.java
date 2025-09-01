package com.iskedyul.iskedyul_backend.entities;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name="degree_programs")
public class DegreeProgram {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    
    private String code;
    
    private String name;

    @Column(name="total_units_required")
    private Integer totalUnitsRequired;
    
    @Column(name="created_at", insertable=false, updatable=false)
    private LocalDate createdAt;
}
