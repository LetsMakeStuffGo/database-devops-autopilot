-- ===========================
-- Script Name: SetupSchemas.sql
-- Description: Create schemas for any AutoPilot database
-- ===========================
-- 
-- INSTRUCTIONS FOR AZURE SQL DATABASE:
-- 1. Connect to the specific database (not master)
-- 2. Run this script to create all required schemas
-- 3. Repeat for each database: dev-001, shadow-001, uat-001, prod-001
-- ===========================

-- Create all required schemas for AutoPilot training
PRINT 'Creating schemas for AutoPilot training...';
GO

CREATE SCHEMA Customers;
GO

CREATE SCHEMA Logistics;
GO

CREATE SCHEMA Operation;
GO

CREATE SCHEMA Sales;
GO

PRINT 'Schema setup completed successfully!';
PRINT 'Available schemas: Customers, Logistics, Operation, Sales';
PRINT 'Ready for Flyway migrations!';
GO