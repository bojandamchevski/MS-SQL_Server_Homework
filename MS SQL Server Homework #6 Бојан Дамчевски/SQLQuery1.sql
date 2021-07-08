USE SEDCHome
GO
CREATE OR ALTER PROCEDURE CreateGradeDetail (
	@AchievementTypeID INT,
	@Points TINYINT,
	@MaxPoints TINYINT,
	@DateForSpecificGrade DATETIME,
	@Output NVARCHAR(100)
) 
AS
BEGIN
    SELECT 
        AchievementTypeID,
		AchievementPoints,
        AchievementMaxPoints,
		AchievementDate,
		SUM(gd.AchievementPoints/gd.AchievementMaxPoints*a.ParticipationRate) AS GradePoints
    FROM
        [dbo].[GradeDetails] AS gd
	INNER JOIN [dbo].[AchievementType] AS a ON a.ID = gd.AchievementTypeID 
	GROUP BY gd.AchievementTypeID, gd.AchievementDate, gd.AchievementMaxPoints, gd.AchievementPoints
	SET @Output = (SELECT AchievementTypeID FROM GradeDetails)
END
GO

DECLARE @result NVARCHAR(100);

EXEC CreateGradeDetail 2, 70,100,'2000-01-01', @result
SELECT @result AS Output
GO