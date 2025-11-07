-- 🔄 U003: Undo Customer Loyalty Program
-- Rolling back the loyalty program if needed

SET NUMERIC_ROUNDABORT OFF

SET
    ANSI_PADDING,
    ANSI_WARNINGS,
    CONCAT_NULL_YIELDS_NULL,
    ARITHABORT,
    QUOTED_IDENTIFIER,
    ANSI_NULLS ON

PRINT N'🔄 Rolling back Customer Loyalty Program...'

-- Drop foreign key constraint first
IF OBJECT_ID('Sales.FK_CustomerLoyalty_Customers', 'F') IS NOT NULL
    ALTER TABLE [Sales].[CustomerLoyalty] DROP CONSTRAINT [FK_CustomerLoyalty_Customers]

-- Drop the loyalty table
IF OBJECT_ID('Sales.CustomerLoyalty', 'U') IS NOT NULL
    DROP TABLE [Sales].[CustomerLoyalty]

PRINT N'😢 Customer Loyalty Program removed' PRINT N'✅ Rollback completed successfully' PRINT N'💡 You can re-run V003 to restore the loyalty program!'