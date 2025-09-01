package com.iskedyul.iskedyul_backend.dtos;

import com.iskedyul.iskedyul_backend.entities.ids.SemesterLimitId;

import lombok.Data;

@Data
public class SemesterLimitDto {
    private SemesterLimitId id;
    private Integer maxUnits;
}
