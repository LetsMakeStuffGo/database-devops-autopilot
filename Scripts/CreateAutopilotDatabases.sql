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
PRINT 'Checking for existing databases...'

-- Check what databases exist
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'db-autopilot-dev-001')
BEGIN
    PRINT 'Found db-autopilot-dev-001 - attempting to drop...'
    DROP DATABASE [db-autopilot-dev-001];
    PRINT 'db-autopilot-dev-001 Database Dropped'
END
ELSE
BEGIN
    PRINT 'db-autopilot-dev-001 Database does not exist - skipping drop'
END;

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'db-autopilot-shadow-001')
BEGIN
    PRINT 'Found db-autopilot-shadow-001 - attempting to drop...'
    DROP DATABASE [db-autopilot-shadow-001];
    PRINT 'db-autopilot-shadow-001 Database Dropped'
END
ELSE
BEGIN
    PRINT 'db-autopilot-shadow-001 Database does not exist - skipping drop'
END;

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'db-autopilot-uat-001')
BEGIN
    PRINT 'Found db-autopilot-uat-001 - attempting to drop...'
    DROP DATABASE [db-autopilot-uat-001];
    PRINT 'db-autopilot-uat-001 Database Dropped'
END
ELSE
BEGIN
    PRINT 'db-autopilot-uat-001 Database does not exist - skipping drop'
END;

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'db-autopilot-prod-001')
BEGIN
    PRINT 'Found db-autopilot-prod-001 - attempting to drop...'
    DROP DATABASE [db-autopilot-prod-001];
    PRINT 'db-autopilot-prod-001 Database Dropped'
END
ELSE
BEGIN
    PRINT 'db-autopilot-prod-001 Database does not exist - skipping drop'
END;

-- Create all databases for complete DevOps pipeline
PRINT 'Creating databases...'

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'db-autopilot-dev-001')
BEGIN
    CREATE DATABASE [db-autopilot-dev-001];
    PRINT 'db-autopilot-dev-001 Database Created';
END
ELSE
BEGIN
    PRINT 'db-autopilot-dev-001 Database already exists';
END;

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'db-autopilot-shadow-001')
BEGIN
    CREATE DATABASE [db-autopilot-shadow-001];
    PRINT 'db-autopilot-shadow-001 Database Created';
END
ELSE
BEGIN
    PRINT 'db-autopilot-shadow-001 Database already exists';
END;

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'db-autopilot-uat-001')
BEGIN
    CREATE DATABASE [db-autopilot-uat-001];
    PRINT 'db-autopilot-uat-001 Database Created';
END
ELSE
BEGIN
    PRINT 'db-autopilot-uat-001 Database already exists';
END;

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'db-autopilot-prod-001')
BEGIN
    CREATE DATABASE [db-autopilot-prod-001];
    PRINT 'db-autopilot-prod-001 Database Created';
END
ELSE
BEGIN
    PRINT 'db-autopilot-prod-001 Database already exists';
END;
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
PRINT N'NEXT STEPS:';
PRINT N'1. Update flyway.toml with your Azure SQL Database connection details';
PRINT N'2. Use Flyway Desktop or CLI to run migrations';
PRINT N'3. The baseline migration (B001) will create all schemas and tables automatically';