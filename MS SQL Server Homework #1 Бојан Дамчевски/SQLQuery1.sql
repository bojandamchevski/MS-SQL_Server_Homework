CREATE DATABASE [homework1];
GO

USE [homework1];
GO

DROP TABLE IF EXISTS [dbo].[student];
DROP TABLE IF EXISTS [dbo].[teacher];
DROP TABLE IF EXISTS [dbo].[gradeDetails];
DROP TABLE IF EXISTS [dbo].[course];
DROP TABLE IF EXISTS [dbo].[grade];
DROP TABLE IF EXISTS [dbo].[achievementType];
GO

CREATE TABLE [dbo].[student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[DateOfBirth] [date] NULL,
	[EnrolledDate] [date] NULL,
	[Gender] [nvarchar](100) NULL,
	[NationalIDNumber] [int] NULL,
	[StudentCardNumber] [int] NULL,
	PRIMARY KEY ([Id])
	);
GO

CREATE TABLE [dbo].[teacher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[DateOfBirth] [date] NULL,
	[AcademicRank] [int] NULL,
	[HireDate] [date] NULL,
	PRIMARY KEY ([Id])
	);
GO

CREATE TABLE [dbo].[gradeDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GradID] [int] NULL,
	[AchievementTypeID] [int] NULL,
	[AchievementPoints] [int] NULL,
	[AchievementMaxPoints] [int] NULL,
	[AchievementDate] [date] NULL,
	PRIMARY KEY ([Id])
	);
GO

CREATE TABLE [dbo].[course](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Credit] [int] NULL,
	[AcademicYear] [int] NULL,
	[Semester] [int] NULL,
	PRIMARY KEY ([Id])
	);
GO

CREATE TABLE [dbo].[grade](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [int] NULL,
	[CourseID] [int] NULL,
	[TeacherID] [int] NULL,
	[Grade] [int] NULL,
	[Comment] [nvarchar](MAX) NULL,
	[CreatedDate] [date] NULL,
	PRIMARY KEY ([Id])
	);
GO

CREATE TABLE [dbo].[achievementType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](MAX) NULL,
	[ParticipationDate] [date] NULL,
	PRIMARY KEY ([Id])
	);
GO