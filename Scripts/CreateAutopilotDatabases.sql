-- ===========================
-- Script Name: CreateAutopilotDatabases.sql
-- Description: Training Database Setup Script
-- ===========================

-- Drop databases if they exist to ensure fresh setup
IF DB_ID('db-autopilot-dev-001') IS NOT NULL
BEGIN
	USE MASTER
    ALTER DATABASE [db-autopilot-dev-001] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

DROP DATABASE [db-autopilot-dev-001];

PRINT 'db-autopilot-dev-001 Database Dropped' END;

IF DB_ID('db-autopilot-uat-001') IS NOT NULL
BEGIN
	USE MASTER
    ALTER DATABASE [db-autopilot-uat-001] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

DROP DATABASE [db-autopilot-uat-001];

PRINT 'db-autopilot-uat-001 Database Dropped' END;

-- Create the two databases
IF DB_ID('db-autopilot-dev-001') IS NULL CREATE DATABASE [db-autopilot-dev-001];

PRINT 'db-autopilot-dev-001 Database Created';

IF DB_ID('db-autopilot-uat-001') IS NULL CREATE DATABASE [db-autopilot-uat-001];

PRINT 'db-autopilot-uat-001 Database Created';
GO

-- Set up Development database
USE [db-autopilot-dev-001];
GO

-- Create schemas in Development
CREATE SCHEMA Customers;
GO
CREATE SCHEMA Logistics;
GO
CREATE SCHEMA Operation;
GO
CREATE SCHEMA Sales;
GO

-- Set up UAT database
USE [db-autopilot-uat-001];
GO

-- Create schemas in UAT
CREATE SCHEMA Customers;
GO
CREATE SCHEMA Logistics;
GO
CREATE SCHEMA Operation;
GO
CREATE SCHEMA Sales;
GO

PRINT N'Database setup completed successfully - 2 databases ready for AutoPilot training';