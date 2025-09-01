package com.iskedyul.iskedyul_backend.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.iskedyul.iskedyul_backend.dtos.DegreeProgramDto;
import com.iskedyul.iskedyul_backend.entities.DegreeProgram;
import com.iskedyul.iskedyul_backend.mappers.DegreeProgramMapper;
import com.iskedyul.iskedyul_backend.repositories.DegreeProgramRepository;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class DegreeProgramService {
    private final DegreeProgramRepository degreeProgramRepository;
    private final DegreeProgramMapper degreeProgramMapper;

    public DegreeProgramDto createDegreeProgram(DegreeProgramDto request) {

        var degreeProgram = new DegreeProgram();    
        
        degreeProgram.setName(request.getName());
        degreeProgram.setCode(request.getCode());
        
        degreeProgramRepository.save(degreeProgram);
        
        return degreeProgramMapper.toDto(degreeProgram);
    }

    public List<DegreeProgramDto> getAllDegreePrograms() {
        return degreeProgramRepository.findAll()
                .stream()
                .map(degreeProgramMapper::toDto)
                .toList();
    }
}
