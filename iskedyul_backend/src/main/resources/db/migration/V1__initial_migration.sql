CREATE TABLE courses (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    units INTEGER NOT NULL,
    created_at DATE DEFAULT (CURDATE())
);

CREATE TABLE course_prerequisites (
    course_id BIGINT NOT NULL,
    prerequisite_course_id BIGINT NOT NULL,
    PRIMARY KEY (course_id, prerequisite_course_id),
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (prerequisite_course_id) REFERENCES courses(id) ON DELETE CASCADE
);

CREATE TABLE degree_programs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(10) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at DATE DEFAULT (CURDATE())
);

CREATE TABLE semester_limits (
    degree_program_id BIGINT NOT NULL,
    year_number INTEGER NOT NULL,
    semester_number INTEGER NOT NULL,
    max_units INTEGER NOT NULL,
    PRIMARY KEY (degree_program_id, year_number, semester_number),
    FOREIGN KEY (degree_program_id) REFERENCES degree_programs(id) ON DELETE CASCADE
);

CREATE TABLE program_courses (
    degree_program_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    is_required BOOLEAN DEFAULT TRUE,                
    PRIMARY KEY (degree_program_id, course_id),
    FOREIGN KEY (degree_program_id) REFERENCES degree_programs(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);