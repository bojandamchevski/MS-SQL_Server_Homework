USE SEDCHome
GO

--Calculate the count of all grades in the system
SELECT COUNT(*) AS TOTAL_GRADES
FROM Grade
GO

--Calculate the count of all grades per Teacher in the system
SELECT COUNT(*) AS TOTAL_GRADES, TeacherID AS TEACHER_ID
FROM Grade
GROUP BY TeacherID
GO

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
SELECT COUNT(*) AS TOTAL_GRADES, TeacherID AS TEACHER_ID
FROM Grade
WHERE StudentID < 100
GROUP BY TeacherID
GO

--Find the Maximal Grade, and the Average Grade per Student on all grades in the system
SELECT MAX(Grade) AS MAX_GRADE, StudentID AS STUDENT_ID
FROM Grade
GROUP BY StudentID
ORDER BY STUDENT_ID ASC
GO

SELECT AVG(Grade.Grade) AS AVG_GRADE, Grade.StudentID AS STUDENT_ID
FROM GRADE
GROUP BY Grade.StudentID
ORDER BY Grade.StudentID ASC
GO

--Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
SELECT COUNT(Grade) AS TOTAL_GRADES, TeacherID AS TEACHER_ID
FROM Grade
GROUP BY TeacherID
HAVING COUNT(Grade) > 200
GO

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count
SELECT COUNT(Grade) AS TOTAL_GRADES, TeacherID AS TEACHER_ID
FROM Grade
GROUP BY TeacherID
HAVING COUNT(Grade.StudentID) < 100 AND COUNT(Grade) < 50
GO

--Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade
SELECT Student.ID, COUNT(Grade) AS TOTAL_GRADES, MAX(Grade) AS MAX_GRADE, AVG(Grade) AS AVG_GRADE
FROM Grade
JOIN Student ON Grade.StudentID = Student.ID
GROUP BY Student.ID
HAVING MAX(Grade) = AVG(Grade)
GO

--List Student First Name and Last Name next to the other details from previous query
ALTER TABLE Grade
ADD FOREIGN KEY (StudentID)
REFERENCES Student(ID)
GO

SELECT Student.ID, Student.LastName AS LAST_NAME, Student.FirstName AS FIRST_NAME, COUNT(Grade) AS TOTAL_GRADES, MAX(Grade) AS MAX_GRADE, AVG(Grade) AS AVG_GRADE
FROM Grade
JOIN Student ON Grade.StudentID = Student.ID
GROUP BY Student.ID, Student.LastName,Student.FirstName
HAVING MAX(Grade) = AVG(Grade)
GO

--Create new view (vv_StudentGrades) that will List all StudentIdsand count of Grades per student
CREATE VIEW vv_StudentGrades
AS
SELECT STUDENT.ID, COUNT(GRADE.Grade) AS TOTAL_GRADES
FROM Grade
JOIN Student ON Grade.StudentID = Student.ID
GROUP BY Student.ID
GO

--Change the view to show Student First and Last Names instead of StudentID
ALTER VIEW vv_StudentGrades
AS
SELECT STUDENT.FirstName, Student.LastName, COUNT(GRADE.Grade) AS TOTAL_GRADES
FROM Grade
JOIN Student ON Grade.StudentID = Student.ID
GROUP BY Student.FirstName, Student.LastName
GO

--List all rows from view ordered by biggest Grade Count
SELECT * 
FROM vv_StudentGrades
ORDER BY TOTAL_GRADES DESC
GO

--Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)
CREATE VIEW vv_StudentGradeDetails
AS
SELECT Student.FirstName, Student.LastName, COUNT(Grade.Grade) AS NUM_COURSES_PASSED, AchievementType.Name
FROM Grade
INNER JOIN Student ON Student.ID = StudentID
INNER JOIN GradeDetails ON GradeDetails.GradeID = Grade.ID
INNER JOIN AchievementType ON AchievementType.ID = GradeDetails.AchievementTypeID
WHERE AchievementType.ParticipationRate < GradeDetails.AchievementPoints
AND AchievementType.Name = 'ISPIT'
GROUP BY Student.FirstName, Student.LastName, AchievementType.Name
GO

SELECT *
FROM vv_StudentGradeDetails
ORDER BY NUM_COURSES_PASSED DESC
GO