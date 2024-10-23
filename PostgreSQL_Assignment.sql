-- Active: 1729188718260@@127.0.0.1@5432@university_db
CREATE DATABASE university_db;

CREATE TABLE students (
    student_id  SERIAL PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    email VARCHAR(50),
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
)

CREATE TABLE courses(
    course_id  SERIAL PRIMARY KEY,
    course_name VARCHAR(50),
    credits  INT
)

CREATE TABLE enrollment(
    enrollment_id  SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id)
)

INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status ) 
       VALUES ('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
              ('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
              ('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
              ('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
              ('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
              ('Hasan', 21, 'hasan@gmail.com', 43, 39, NULL);

INSERT INTO courses (course_name, credits)
       VALUES('Next.js', 3),
             ('React.js', 4),
             ('Database', 3),
             ('Prisma', 3);

INSERT INTO enrollment(student_id,course_id)
       VALUES(1, 1),
             (1, 2),
             (2, 1),
             (3, 2);


SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollment;

DROP TABLE students;


-- Query 1:
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status ) 
       VALUES ('Anamul', 21, 'anamul@example.com', 45, 55, NULL);


-- Query 2:
SELECT 
    students.student_name
FROM 
    enrollment
JOIN 
    students ON students.student_id = enrollment.student_id
JOIN 
    courses ON courses.course_id = enrollment.course_id
WHERE 
    courses.course_name = 'Next.js';


-- Query 3:
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    GROUP BY student_id
    ORDER BY SUM(frontend_mark + backend_mark) DESC
    LIMIT 1
);


-- Query 4: 
DELETE FROM courses
       WHERE NOT EXISTS (
        SELECT 1 
        FROM enrollment 
        WHERE enrollment.course_id = courses.course_id
    );

-- Query 5:
SELECT student_name FROM students LIMIT 2 OFFSET 2 * 1;

-- Query 6: 
SELECT courses.course_name,
    COUNT(enrollment.student_id) AS enrolled_students
         FROM courses
         LEFT JOIN enrollment ON courses.course_id = enrollment.course_id
         GROUP BY courses.course_name;

-- Query 7:
SELECT AVG(age)::NUMERIC(10,2) as average_age FROM students;

-- Query 
SELECT student_name FROM students
    WHERE email LIKE '%example.com%';