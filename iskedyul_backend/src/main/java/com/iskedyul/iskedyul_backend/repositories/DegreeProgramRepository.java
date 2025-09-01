package com.iskedyul.iskedyul_backend.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.iskedyul.iskedyul_backend.entities.DegreeProgram;

@Repository
public interface DegreeProgramRepository extends JpaRepository<DegreeProgram, Long> {

}
