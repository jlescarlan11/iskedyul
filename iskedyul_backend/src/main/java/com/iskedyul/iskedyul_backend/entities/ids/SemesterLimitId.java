package com.iskedyul.iskedyul_backend.entities.ids;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@Embeddable
public class SemesterLimitId  implements Serializable{
    @Column(name = "degree_program_id")
    private Long degreeProgramId;

    @Column(name = "year_number")
    private Integer yearNumber;

    @Column(name = "semester_number")
    private Integer semesterNumber;
}
