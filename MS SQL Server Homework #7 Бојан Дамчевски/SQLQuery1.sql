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
    FROM [dbo].[GradeDetails] AS gd
	INNER JOIN [dbo].[AchievementType] AS a ON a.ID = gd.AchievementTypeID 
	GROUP BY gd.AchievementTypeID, gd.AchievementDate, gd.AchievementMaxPoints, gd.AchievementPoints

	BEGIN TRY
	INSERT INTO [dbo].[GradeDetails] (AchievementTypeID,
		AchievementPoints,
        AchievementMaxPoints,
		AchievementDate
		)
	VALUES (
	@AchievementTypeID,
	@Points,
	@MaxPoints,
	@DateForSpecificGrade
	)
	END TRY
	BEGIN CATCH  
	SELECT  
		ERROR_NUMBER() AS ErrorNumber  
		,ERROR_SEVERITY() AS ErrorSeverity  
		,ERROR_STATE() AS ErrorState  
		,ERROR_PROCEDURE() AS ErrorProcedure  
		,ERROR_LINE() AS ErrorLine  
		,ERROR_MESSAGE() AS ErrorMessage;  
	END CATCH;  

	SET @Output = (SELECT AchievementTypeID FROM GradeDetails)
END
GO

DECLARE @result NVARCHAR(100);

EXEC CreateGradeDetail 2, 70,100,'2000-01-01', @result
SELECT @result AS Output
GO