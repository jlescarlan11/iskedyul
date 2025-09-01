package com.iskedyul.iskedyul_backend.mappers;

import org.mapstruct.Mapper;

import com.iskedyul.iskedyul_backend.dtos.DegreeProgramDto;
import com.iskedyul.iskedyul_backend.entities.DegreeProgram;

@Mapper(componentModel = "spring")
public interface DegreeProgramMapper {
    DegreeProgramDto toDto(DegreeProgram degreeProgram);
}