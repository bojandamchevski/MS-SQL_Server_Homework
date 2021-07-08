USE SEDCHome
GO

CREATE OR ALTER PROCEDURE dbo.CreateGrade(
@StudentID INT,
@TeacherID SMALLINT,
@CourseID SMALLINT,
@CreatedDate datetime,
@Grade TINYINT
)
AS
BEGIN

	INSERT INTO dbo.[Grade](StudentID, TeacherID, CourseID, CreatedDate,Grade)
	VALUES (@StudentID, @TeacherID, @CourseID, @CreatedDate, @Grade)

	SELECT G.TeacherID, G.StudentID, COUNT(G.Grade) AS Total_Grades_Per_Student
	FROM dbo.[Grade] G
	WHERE StudentID = @StudentID
	GROUP BY G.TeacherID, G.StudentID

	SELECT G.TeacherID, G.StudentID, MAX(G.Grade) AS Max_Grade_Per_Student_From_Teacher
	FROM dbo.[Grade] G
	WHERE StudentID = @StudentID AND TeacherID = @TeacherID
	GROUP BY G.TeacherID, G.StudentID

END
GO

EXEC dbo.CreateGrade
@StudentID = 1,
@TeacherID= 3,
@CourseID = 1,
@CreatedDate = '2000-02-06',
@Grade = 6