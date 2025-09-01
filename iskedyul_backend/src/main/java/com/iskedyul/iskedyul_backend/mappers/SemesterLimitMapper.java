package com.iskedyul.iskedyul_backend.mappers;

import org.mapstruct.Mapper;

import com.iskedyul.iskedyul_backend.dtos.SemesterLimitDto;
import com.iskedyul.iskedyul_backend.entities.SemesterLimit;

@Mapper(componentModel = "spring")
public interface SemesterLimitMapper {
    SemesterLimitDto toDto(SemesterLimit semesterLimit);
}