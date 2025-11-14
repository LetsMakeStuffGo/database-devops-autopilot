-- ===========================
-- Script Name: CreateAutopilotDatabases.sql
-- Description: Training Database Setup Script for Azure SQL Database
-- ===========================
-- 
-- IMPORTANT: Azure SQL Database does not support USE statements
-- You must run this script while connected to the MASTER database
-- Then run the schema setup scripts for each individual database
-- ===========================

-- Drop databases if they exist to ensure fresh setup
IF DB_ID('db-autopilot-dev-001') IS NOT NULL
BEGIN
    ALTER DATABASE [db-autopilot-dev-001] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [db-autopilot-dev-001];
    PRINT 'db-autopilot-dev-001 Database Dropped'
END;

IF DB_ID('db-autopilot-shadow-001') IS NOT NULL
BEGIN
    ALTER DATABASE [db-autopilot-shadow-001] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [db-autopilot-shadow-001];
    PRINT 'db-autopilot-shadow-001 Database Dropped'
END;

IF DB_ID('db-autopilot-uat-001') IS NOT NULL
BEGIN
    ALTER DATABASE [db-autopilot-uat-001] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [db-autopilot-uat-001];
    PRINT 'db-autopilot-uat-001 Database Dropped'
END;

IF DB_ID('db-autopilot-prod-001') IS NOT NULL
BEGIN
    ALTER DATABASE [db-autopilot-prod-001] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [db-autopilot-prod-001];
    PRINT 'db-autopilot-prod-001 Database Dropped'
END;

-- Create all databases for complete DevOps pipeline
IF DB_ID('db-autopilot-dev-001') IS NULL CREATE DATABASE [db-autopilot-dev-001];
PRINT 'db-autopilot-dev-001 Database Created';

IF DB_ID('db-autopilot-shadow-001') IS NULL CREATE DATABASE [db-autopilot-shadow-001];
PRINT 'db-autopilot-shadow-001 Database Created';

IF DB_ID('db-autopilot-uat-001') IS NULL CREATE DATABASE [db-autopilot-uat-001];
PRINT 'db-autopilot-uat-001 Database Created';

IF DB_ID('db-autopilot-prod-001') IS NULL CREATE DATABASE [db-autopilot-prod-001];
PRINT 'db-autopilot-prod-001 Database Created';
GO

PRINT N'Database setup completed successfully - 4 databases ready for AutoPilot training:';
PRINT N'  - db-autopilot-dev-001 (Development)';
PRINT N'  - db-autopilot-shadow-001 (Shadow/Validation)';
PRINT N'  - db-autopilot-uat-001 (User Acceptance Testing)';
PRINT N'  - db-autopilot-prod-001 (Production)';
PRINT N'';
PRINT N'Environment Flow: DEV ↔ SHADOW → UAT → PRODUCTION';
PRINT N'Shadow database is used for schema drift detection and migration validation.';
PRINT N'';
PRINT N'NEXT STEPS for Azure SQL Database:';
PRINT N'1. Connect to each database individually';
PRINT N'2. Run the schema creation script for each database:';
PRINT N'   - Connect to db-autopilot-dev-001 and run SetupSchemas.sql';
PRINT N'   - Connect to db-autopilot-shadow-001 and run SetupSchemas.sql';
PRINT N'   - Connect to db-autopilot-uat-001 and run SetupSchemas.sql';
PRINT N'   - Connect to db-autopilot-prod-001 and run SetupSchemas.sql';
PRINT N'3. Or use the individual database setup scripts in the Scripts folder';