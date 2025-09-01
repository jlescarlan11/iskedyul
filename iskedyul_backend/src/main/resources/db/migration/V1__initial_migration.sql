
CREATE TABLE degree_programs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL,
    total_units_required INTEGER NOT NULL,
    created_at DATE DEFAULT (CURDATE())
);


CREATE TABLE courses (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    units INTEGER NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATE DEFAULT (CURDATE())
);


CREATE TABLE students (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    degree_program_id BIGINT NOT NULL,
    FOREIGN KEY (degree_program_id) REFERENCES degree_programs(id)
);


CREATE TABLE course_prerequisites (
    course_id BIGINT NOT NULL,
    prerequisite_course_id BIGINT NOT NULL,
    PRIMARY KEY (course_id, prerequisite_course_id),
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (prerequisite_course_id) REFERENCES courses(id) ON DELETE CASCADE
);