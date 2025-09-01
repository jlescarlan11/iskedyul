package com.iskedyul.iskedyul_backend.dtos;

import java.util.Set;

import lombok.Data;

@Data
public class DegreeProgramDto {
    private Long id; 
    private String name;
    private String code;
    private Set<SemesterLimitDto> semesterLimits;
}
