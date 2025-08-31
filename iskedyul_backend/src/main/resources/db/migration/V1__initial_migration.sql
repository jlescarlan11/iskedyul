-- Programs table
CREATE TABLE programs (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    total_units SMALLINT NOT NULL DEFAULT 120,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_program_code (code)
) ENGINE=InnoDB;

-- Users table
CREATE TABLE users (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    program_id BINARY(16) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (program_id) REFERENCES programs(id),
    INDEX idx_user_program (program_id)
) ENGINE=InnoDB;

-- Courses table
CREATE TABLE courses (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(150) NOT NULL,
    units DECIMAL(3,1) NOT NULL DEFAULT 3.0,
    course_type ENUM('CORE', 'GE', 'ELECTIVE', 'FREE') NOT NULL DEFAULT 'CORE',
    offering_pattern VARCHAR(10) DEFAULT 'BOTH', -- 'FALL', 'SPRING', 'SUMMER', 'BOTH'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_course_code (code),
    INDEX idx_course_type_offering (course_type, offering_pattern),
    CHECK (units > 0 AND units <= 6.0)
) ENGINE=InnoDB;

-- Prerequisites table
CREATE TABLE prerequisites (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    course_id BINARY(16) NOT NULL,
    prerequisite_course_id BINARY(16) NOT NULL,
    prerequisite_group CHAR(1) DEFAULT 'A', -- For OR logic: A, B, C
    
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (prerequisite_course_id) REFERENCES courses(id) ON DELETE CASCADE,
    
    UNIQUE KEY unique_prerequisite (course_id, prerequisite_course_id),
    INDEX idx_prereq_course (course_id),
    CHECK (course_id != prerequisite_course_id)
) ENGINE=InnoDB;

-- Curriculum table
CREATE TABLE curriculum (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    program_id BINARY(16) NOT NULL,
    course_id BINARY(16), -- NULL for elective slots
    year_level TINYINT NOT NULL,
    semester ENUM('FIRST', 'SECOND', 'MIDYEAR') NOT NULL,
    is_required BOOLEAN NOT NULL DEFAULT true,
    sort_order TINYINT DEFAULT 0,
    
    FOREIGN KEY (program_id) REFERENCES programs(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE SET NULL,
    
    UNIQUE KEY unique_curriculum (program_id, course_id, year_level, semester),
    INDEX idx_curriculum_program_semester (program_id, year_level, semester),
    CHECK (year_level BETWEEN 1 AND 6)
) ENGINE=InnoDB;

-- Student progress table
CREATE TABLE student_progress (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    user_id BINARY(16) NOT NULL,
    course_id BINARY(16) NOT NULL,
    status ENUM('PLANNED', 'ENROLLED', 'COMPLETED', 'REMOVAL', 'FAILED', 'DROPPED', 'INCOMPLETE') NOT NULL DEFAULT 'PLANNED',
    grade DECIMAL(3,2), -- Philippine grading: 1.00, 1.25, ..., 5.00
    units_earned DECIMAL(3,1) DEFAULT 0,
    semester_taken ENUM('FIRST', 'SECOND', 'MIDYEAR') NOT NULL,
    year_taken YEAR,
    removal_exam_passed BOOLEAN DEFAULT NULL, -- Only for grade = 4.00
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    
    UNIQUE KEY unique_enrollment (user_id, course_id, semester_taken, year_taken),
    INDEX idx_progress_user_status (user_id, status),
    INDEX idx_progress_semester (semester_taken, year_taken),
    
    CHECK (units_earned >= 0 AND units_earned <= 6.0),
    CHECK (grade IS NULL OR grade IN (1.00, 1.25, 1.50, 1.75, 2.00, 2.25, 2.50, 2.75, 3.00, 4.00, 5.00)),
    CHECK ((grade != 4.00 AND removal_exam_passed IS NULL) OR (grade = 4.00))
) ENGINE=InnoDB;