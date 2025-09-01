package com.iskedyul.iskedyul_backend.controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import com.iskedyul.iskedyul_backend.dtos.DegreeProgramDto;
import com.iskedyul.iskedyul_backend.services.DegreeProgramService;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@RestController
@RequestMapping("/api/degree-programs")
public class DegreeProgramController {
    private final DegreeProgramService degreeProgramService;

    @PostMapping
    public ResponseEntity<DegreeProgramDto> createDegreeProgram(
        UriComponentsBuilder uriBuilder,
        @RequestBody DegreeProgramDto request
    ) {

        var degreeProgramDto = degreeProgramService.createDegreeProgram(request);
        var uri = uriBuilder.path("/degree-program/{id}").buildAndExpand(degreeProgramDto.getId()).toUri();

        return ResponseEntity.created(uri).body(degreeProgramDto);
    }

    @GetMapping
    public ResponseEntity<List<DegreeProgramDto>> getAllDegreePrograms() {
 
        List<DegreeProgramDto> degreePrograms = degreeProgramService.getAllDegreePrograms();

        return ResponseEntity.ok(degreePrograms);
    }
}
 