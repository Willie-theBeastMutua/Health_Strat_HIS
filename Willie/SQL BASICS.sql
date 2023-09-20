USE giraffe;
CREATE TABLE student (
	student_id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    major VARCHAR(20)
);
DESCRIBE student;
ALTER TABLE student ADD gpa DECIMAL(3, 2);
ALTER TABLE student DROP gpa;
INSERT INTO student VALUES (1, 'Jack', 'Biology');
INSERT INTO student VALUES (2, 'kate', 'Sociology');
INSERT INTO student VALUES (3, 'claire', 'Chemistry');
INSERT INTO student VALUES (4, 'Jack', 'Biology');
INSERT INTO student VALUES (5, 'Mike', 'Computer Science');

UPDATE student 
SET major = 'Biochemistry'
WHERE major = 'Biology' OR major = 'chemistry';

SELECT * FROM student;

DELETE FROM student
	WHERE student_id = 4;
 
DROP TABLE student;