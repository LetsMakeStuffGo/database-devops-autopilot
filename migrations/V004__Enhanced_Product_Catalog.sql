-- 🛒 V004: Enhanced Product Catalog
-- Adding product reviews and inventory tracking

SET NUMERIC_ROUNDABORT OFF
GO

SET
    ANSI_PADDING,
    ANSI_WARNINGS,
    CONCAT_NULL_YIELDS_NULL,
    ARITHABORT,
    QUOTED_IDENTIFIER,
    ANSI_NULLS ON
GO

PRINT N'🛒 Enhancing Product Catalog with Reviews and Inventory...'
GO

-- Create Product Reviews table
CREATE TABLE [Operation].[ProductReviews]
(
    [ReviewID] [int] IDENTITY(1,1) NOT NULL,
    [ProductID] [int] NOT NULL,
    [CustomerID] [nchar](5) NOT NULL,
    [Rating] [int] NOT NULL,
    [ReviewTitle] [nvarchar](100) NULL,
    [ReviewText] [nvarchar](1000) NULL,
    [ReviewDate] [datetime] NOT NULL DEFAULT (GETDATE()),
    [IsVerifiedPurchase] [bit] NOT NULL DEFAULT (0),
    CONSTRAINT [PK_ProductReviews] PRIMARY KEY CLUSTERED ([ReviewID]),
    CONSTRAINT [CK_ProductReviews_Rating] CHECK ([Rating] >= 1 AND [Rating] <= 5)
)
GO

-- Add foreign key constraints separately
ALTER TABLE [Operation].[ProductReviews]
ADD CONSTRAINT [FK_ProductReviews_Products] 
FOREIGN KEY ([ProductID]) REFERENCES [Operation].[Products] ([ProductID])
GO

-- Add foreign key constraint for product reviews (only if Customers table exists)
IF OBJECT_ID(N'[Sales].[Customers]', N'U') IS NOT NULL
BEGIN
    ALTER TABLE [Operation].[ProductReviews]
    ADD CONSTRAINT [FK_ProductReviews_Customers] 
    FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customers] ([CustomerID])
    PRINT N'✅ Foreign key constraint FK_ProductReviews_Customers added'
END
ELSE
BEGIN
    PRINT N'⚠️  WARNING: Sales.Customers table not found - Foreign key constraint skipped'
    PRINT N'   Please ensure baseline migration B001 has been applied first'
END
GO
-- Add some exciting sample reviews (only if required tables exist)
IF OBJECT_ID(N'[Sales].[Customers]', N'U') IS NOT NULL
BEGIN
    INSERT INTO [Operation].[ProductReviews] (ProductID, CustomerID, Rating, ReviewTitle, ReviewText, IsVerifiedPurchase)
    VALUES 
    (1, 'ALFKI', 5, 'Amazing iPhone!', 'The iPhone 15 Pro is absolutely fantastic! Camera quality is incredible and performance is blazing fast.', 1),
    (2, 'ANATR', 4, 'Great Android Phone', 'Samsung Galaxy S24 is excellent. Love the display and battery life.', 1),
    (4, 'ANTON', 5, 'Gaming Paradise!', 'PlayStation 5 is a game-changer! Graphics are mind-blowing and load times are super fast.', 1),
    (6, 'AROUT', 5, 'Nintendo Magic', 'Switch OLED is perfect for gaming on the go. My kids love it!', 1),
    (8, 'BERGS', 5, 'Must-read for developers!', 'The Pragmatic Programmer changed how I think about coding. Highly recommended!', 1)
    PRINT N'✅ Sample product reviews added'
END
ELSE
BEGIN
    PRINT N'⚠️  WARNING: Required tables not found - Sample reviews skipped'
    PRINT N'   Please ensure baseline migration B001 has been applied first'
END
GO
-- Create inventory audit table
CREATE TABLE [Operation].[InventoryAudit]
(
    [AuditID] [int] IDENTITY(1,1) NOT NULL,
    [ProductID] [int] NOT NULL,
    [ChangeDate] [datetime] NOT NULL DEFAULT (GETDATE()),
    [OldQuantity] [int] NOT NULL,
    [NewQuantity] [int] NOT NULL,
    [ChangeReason] [nvarchar](100) NULL,
    [ChangedBy] [nvarchar](50) NULL,
    CONSTRAINT [PK_InventoryAudit] PRIMARY KEY CLUSTERED ([AuditID])
)
GO

-- Add foreign key constraint for inventory audit (only if Products table exists)
IF OBJECT_ID(N'[Operation].[Products]', N'U') IS NOT NULL
BEGIN
    ALTER TABLE [Operation].[InventoryAudit]
    ADD CONSTRAINT [FK_InventoryAudit_Products] 
    FOREIGN KEY ([ProductID]) REFERENCES [Operation].[Products] ([ProductID])
    PRINT N'✅ Foreign key constraint FK_InventoryAudit_Products added'
END
ELSE
BEGIN
    PRINT N'⚠️  WARNING: Operation.Products table not found - Foreign key constraint skipped'
    PRINT N'   Please ensure baseline migration B001 has been applied first'
END
GO

PRINT N'✅ Product Reviews system implemented!'
PRINT N'⭐ Customer reviews with 1-5 star ratings'
PRINT N'📦 Inventory audit tracking added'
PRINT N'🎯 Ready for customer engagement!'
GO