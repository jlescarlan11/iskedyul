package com.iskedyul.iskedyul_backend.dtos;

import lombok.Data;

@Data
public class DegreeProgramDto {
    private Long id; 
    private String name;
    private String code;
    private Integer totalUnitsRequired;
}
