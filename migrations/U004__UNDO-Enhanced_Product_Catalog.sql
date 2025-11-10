-- 🔄 U004: UNDO Enhanced Product Catalog
-- Removing product reviews and inventory tracking tables

SET NUMERIC_ROUNDABORT OFF

SET
    ANSI_PADDING,
    ANSI_WARNINGS,
    CONCAT_NULL_YIELDS_NULL,
    ARITHABORT,
    QUOTED_IDENTIFIER,
    ANSI_NULLS ON

PRINT N'🔄 Undoing Enhanced Product Catalog changes...'

-- Drop inventory audit table
IF OBJECT_ID('[Operation].[InventoryAudit]', 'U') IS NOT NULL
BEGIN
    PRINT N'📦 Dropping InventoryAudit table...'
    DROP TABLE [Operation].[InventoryAudit]
    PRINT N'✅ InventoryAudit table removed'
END
ELSE
BEGIN
    PRINT N'ℹ️ InventoryAudit table does not exist - skipping'
END

-- Drop product reviews table
IF OBJECT_ID('[Operation].[ProductReviews]', 'U') IS NOT NULL
BEGIN
    PRINT N'⭐ Dropping ProductReviews table...'
    DROP TABLE [Operation].[ProductReviews]
    PRINT N'✅ ProductReviews table removed'
END
ELSE
BEGIN
    PRINT N'ℹ️ ProductReviews table does not exist - skipping'
END

PRINT N'🔄 Enhanced Product Catalog undo completed!'
PRINT N'📋 Removed: Product reviews and inventory audit tables'
PRINT N'⚠️ Note: Any existing review data has been permanently deleted'