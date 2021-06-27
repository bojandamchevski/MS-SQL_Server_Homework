USE SEDCHome

--1

DECLARE @FirstName NVARCHAR(50)
SET @FirstName = 'Aleksandar'

SELECT *
FROM dbo.Student
WHERE FirstName = @FirstName
GO

--2

DECLARE @FemaleStudents TABLE(
	StudentId INT,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	DateOfBirth date
);

INSERT INTO @FemaleStudents
SELECT ID, FirstName, LastName, DateOfBirth
FROM dbo.Student
WHERE Gender = 'F'
SELECT *
FROM @FemaleStudents
GO

--3

CREATE TABLE #TempStudent(
	LastName NVARCHAR(50),
	EnrolledDate date
);
GO

INSERT INTO #TempStudent
SELECT LastName, EnrolledDate
FROM Student
WHERE Gender = 'M' AND FirstName LIKE 'A%'
GO

SELECT *
FROM #TempStudent
WHERE LEN(LastName) = 7
GO

--4

SELECT *
FROM dbo.Teacher
WHERE LEN(FirstName) < 5 AND LEFT(FirstName,3) = LEFT(LastName,3)
GO

--5

CREATE FUNCTION dbo.fn_FormatStudentName(@StudentId int)
	RETURNS nvarchar(2000)
	AS
	BEGIN
		
		declare @Result nvarchar(2000)

			select @Result = REPLACE(Student.StudentCardNumber,'sc-','') + '-' + LEFT(FirstName,1) + '.' + LastName
			from dbo.Student
			where id = @StudentId

		RETURN @Result
	END
	GO
SELECT *,dbo.fn_FormatStudentName (id) AS FunctionOutput
FROM dbo.Student