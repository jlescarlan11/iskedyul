package com.iskedyul.iskedyul_backend.entities;

import com.iskedyul.iskedyul_backend.entities.ids.SemesterLimitId;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name="semester_limits")
public class SemesterLimit {

    @EmbeddedId
    private SemesterLimitId id;

    @ManyToOne
    @MapsId("degreeProgramId") // link FK to embeddedId field
    @JoinColumn(name = "degree_program_id", nullable = false)
    private DegreeProgram degreeProgram;

    @Column(name = "max_units")
    private Integer maxUnits;
}
