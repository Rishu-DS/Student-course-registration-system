
-- Create Students table
CREATE TABLE Students (
    Student_ID VARCHAR(10) PRIMARY KEY,
    Student_Name VARCHAR(50) NOT NULL,
    Department   VARCHAR(30) NOT NULL
);

-- Create Courses table
CREATE TABLE Courses (
    Course_ID   VARCHAR(10) PRIMARY KEY,
    Course_Name VARCHAR(50) NOT NULL,
    Department  VARCHAR(30) NOT NULL
);

-- Create Registrations table
CREATE TABLE Registrations (
    Registration_ID SERIAL PRIMARY KEY,
    Student_ID  VARCHAR(10) REFERENCES Students(Student_ID) ON DELETE CASCADE,
    Course_ID   VARCHAR(10) REFERENCES Courses(Course_ID) ON DELETE CASCADE, 
    Semester    INT NOT NULL
);
   

-- Indexes for efficient querying
CREATE INDEX idx_reg_student ON Registrations(Student_ID);
CREATE INDEX idx_reg_course  ON Registrations(Course_ID);
CREATE INDEX idx_reg_semester ON Registrations(Semester);




-- Insert Registrations
INSERT INTO Registrations (Student_ID, Course_ID, Semester) VALUES
('S101', 'CSE101', 3),
('S101', 'CSE102', 3),
('S102', 'CSE102', 3),
('S103', 'EEE101', 3);

-- Students Enrolled in Each Course
SELECT
    R.Course_ID,
    C.Course_Name,
    COUNT(DISTINCT R.Student_ID) AS Num_Students
FROM
    Registrations R
JOIN
    Courses C ON R.Course_ID = C.Course_ID
GROUP BY
    R.Course_ID, C.Course_Name
ORDER BY
    Num_Students DESC;

-- Student-wise Course List
SELECT
    S.Student_ID,
    S.Student_Name,
    C.Course_Name,
    R.Semester
FROM
    Students S
JOIN
    Registrations R ON S.Student_ID = R.Student_ID
JOIN
    Courses C ON R.Course_ID = C.Course_ID
ORDER BY
    S.Student_ID, R.Semester, C.Course_Name;

--Aggregate Number of students per Course per semester
SELECT
    R.Course_ID,
    C.Course_Name,
    R.Semester,
    COUNT(DISTINCT R.Student_ID) AS Num_Students
FROM
    Registrations R
JOIN
    Courses C ON R.Course_ID = C.Course_ID
GROUP BY
    R.Course_ID, C.Course_Name, R.Semester
ORDER BY
    R.Course_ID, R.Semester;

--Filter By Semester or Department
SELECT
    R.Semester,
    C.Course_ID,
    C.Course_Name,
    COUNT(DISTINCT R.Student_ID) AS Num_Students
FROM
    Registrations R
JOIN
    Courses C ON R.Course_ID = C.Course_ID
WHERE
    R.Semester = 3
GROUP BY
    R.Semester, C.Course_ID, C.Course_Name;

--Filter by department 
SELECT
    C.Department,
    C.Course_ID,
    C.Course_Name,
    COUNT(DISTINCT R.Student_ID) AS Num_Students
FROM
    Registrations R
JOIN
    Courses C ON R.Course_ID = C.Course_ID
WHERE
    C.Department = 'CSE'
GROUP BY
    C.Department, C.Course_ID, C.Course_Name;

