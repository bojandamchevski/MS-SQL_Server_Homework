SELECT * FROM Student
WHERE FirstName = 'Antonio'
GO

SELECT * FROM Student
WHERE DateOfBirth > '01.01.1999'
GO

SELECT * FROM Student
WHERE GENDER = 'M'
GO

SELECT * FROM Student
WHERE LastName LIKE 'T%'
GO

SELECT * FROM Student
WHERE EnrolledDate BETWEEN '01.01.1998' AND '01.31.1998'
GO

SELECT * FROM Student
WHERE FirstName LIKE 'J%' AND EnrolledDate BETWEEN '01.01.1998' AND '01.31.1998'
GO

SELECT LastName, FirstName FROM Student
WHERE FirstName = 'Antonio'
ORDER BY LastName
ASC
GO

SELECT FirstName,LastName FROM Student
ORDER BY FirstName
ASC
GO

SELECT * FROM Student
WHERE Gender = 'M'
ORDER BY EnrolledDate
DESC
GO

SELECT FirstName FROM Student
UNION ALL
SELECT FirstName FROM Teacher
GO

SELECT LastName FROM Student
UNION
SELECT LastName FROM Teacher
GO

SELECT FirstName FROM Student
INTERSECT
SELECT FirstName FROM Teacher
GO

ALTER TABLE dbo.GradeDetails
ADD CONSTRAINT DF_Achievement_Max_Points
DEFAULT 100 FOR [AchievementMaxPoints]
GO

ALTER TABLE dbo.GradeDetails WITH CHECK
ADD CONSTRAINT CHK_Achievement_Points
CHECK (AchievementMaxPoints >= AchievementPoints);
GO

ALTER TABLE dbo.AchievementType WITH CHECK
ADD CONSTRAINT UC_Achievement_Type UNIQUE (Name)
GO

ALTER TABLE Grade
ADD FOREIGN KEY (StudentID)
REFERENCES Student(ID)
GO

ALTER TABLE Grade
ADD FOREIGN KEY (CourseID)
REFERENCES Course(ID)
GO

ALTER TABLE Grade
ADD FOREIGN KEY (TeacherID)
REFERENCES Teacher(ID)
GO

ALTER TABLE GradeDetails
ADD FOREIGN KEY (GradeID)
REFERENCES Grade(ID)
GO

ALTER TABLE GradeDetails
ADD FOREIGN KEY (AchievementTypeID)
REFERENCES AchievementType(ID)
GO

SELECT DISTINCT Name FROM Course
GO

SELECT DISTINCT Name FROM AchievementType
GO

SELECT * FROM Grade
WHERE TeacherID <> 0
GO

SELECT * FROM Grade
WHERE TeacherID = 0
GO

SELECT Student.FirstName, Student.LastName, Grade.Grade
FROM Grade
RIGHT JOIN Student
ON Student.ID = 0 AND Grade.StudentID = 0
WHERE StudentID IS NULL
GO