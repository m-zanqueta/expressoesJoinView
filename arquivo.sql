--Ex 1
SELECT i.ID, i.name, COUNT(t.sec_id) AS "Number of sections"
FROM instructor i
LEFT OUTER JOIN teaches t ON i.ID = t.ID
GROUP BY i.ID, i.name;

--Ex 2
SELECT i.ID, i.name, 
       (SELECT COUNT(*) 
        FROM teaches t 
        WHERE t.ID = i.ID) AS "Number of sections"
FROM instructor i;

--Ex 3
SELECT s.course_id, s.sec_id, t.ID, s.semester, s.year, 
       COALESCE(i.name, '-') AS name
FROM section s
LEFT OUTER JOIN teaches t ON s.course_id = t.course_id 
    AND s.sec_id = t.sec_id 
    AND s.semester = t.semester 
    AND s.year = t.year
LEFT OUTER JOIN instructor i ON t.ID = i.ID
WHERE s.semester = 'Spring' AND s.year = 2010;

-- Ex 4
WITH grade_points (grade, points) AS (
    SELECT * FROM (VALUES 
        ('A+', 4.0), ('A', 3.7), ('A-', 3.4), 
        ('B+', 3.1), ('B', 3.0), ('B-', 2.7), 
        ('C+', 2.3), ('C', 2.0), ('C-', 1.7)
    ) AS temp(g, p)
)
SELECT 
    s.ID, 
    s.name, 
    c.title, 
    s.dept_name, 
    tk.grade, 
    gp.points, 
    c.credits, 
    (gp.points * c.credits) AS "Pontos totais"
FROM student s
JOIN takes tk ON s.ID = tk.ID
JOIN course c ON tk.course_id = c.course_id
JOIN grade_points gp ON tk.grade = gp.grade;

-- Ex5
CREATE VIEW coeficiente_rendimento AS
WITH grade_points (grade, points) AS (
    SELECT * FROM (VALUES 
        ('A+', 4.0), ('A', 3.7), ('A-', 3.4), 
        ('B+', 3.1), ('B', 3.0), ('B-', 2.7), 
        ('C+', 2.3), ('C', 2.0), ('C-', 1.7)
    ) AS temp(g, p)
)
SELECT 
    s.ID, s.name, c.title, s.dept_name, tk.grade, gp.points, c.credits, 
    (gp.points * c.credits) AS "Pontos totais"
FROM student s
JOIN takes tk ON s.ID = tk.ID
JOIN course c ON tk.course_id = c.course_id
JOIN grade_points gp ON tk.grade = gp.grade;