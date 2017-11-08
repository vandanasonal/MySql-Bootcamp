CREATE TABLE students(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100)
);

CREATE TABLE papers(
title VARCHAR(200),
grade INT,
student_id INT,
FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE
);

    INSERT INTO students (first_name) VALUES 
    ('Caleb'), 
    ('Samantha'), 
    ('Raj'), 
    ('Carlos'), 
    ('Lisa');
     
    INSERT INTO papers (student_id, title, grade ) VALUES
    (1, 'My First Book Report', 60),
    (1, 'My Second Book Report', 75),
    (2, 'Russian Lit Through The Ages', 94),
    (2, 'De Montaigne and The Art of The Essay', 98),
    (4, 'Borges and Magical Realism', 89);
    
--Problem1
SELECT first_name,title,grade FROM students
INNER JOIN papers
ON papers.student_id = students.id
ORDER BY grade DESC
;

--Problem2
SELECT first_name,title,grade FROM students
LEFT JOIN papers
ON papers.student_id = students.id
;

--Problem3
SELECT 
    first_name,
    IFNULL(title,'MISSING'),
    IFNULL(grade,0)
FROM students
LEFT JOIN papers
ON papers.student_id = students.id
;

--Problem 4
SELECT first_name, 
IFNULL(AVG(grade) ,0) AS averages
FROM students
LEFT JOIN papers
ON papers.student_id = students.id
GROUP BY id
ORDER BY averages DESC;

--Problem 5
SELECT first_name, 
IFNULL(AVG(grade) ,0) AS averages,
  CASE
     WHEN AVG(grade) IS NULL THEN 'FAILING'
     WHEN AVG(grade) >= 75 THEN 'PASSING'
     ELSE 'FAILING'
  END AS passing_status
FROM students
LEFT JOIN papers
ON papers.student_id = students.id
GROUP BY id
ORDER BY averages DESC;
