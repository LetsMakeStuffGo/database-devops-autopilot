-- 🛒 V004: Enhanced Product Catalog
-- Adding product reviews and inventory tracking

SET NUMERIC_ROUNDABORT OFF

SET
    ANSI_PADDING,
    ANSI_WARNINGS,
    CONCAT_NULL_YIELDS_NULL,
    ARITHABORT,
    QUOTED_IDENTIFIER,
    ANSI_NULLS ON

PRINT N'🛒 Enhancing Product Catalog with Reviews and Inventory...'
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
    CONSTRAINT [FK_ProductReviews_Products] FOREIGN KEY ([ProductID]) REFERENCES [Operation].[Products] ([ProductID]),
    CONSTRAINT [FK_ProductReviews_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customers] ([CustomerID]),
    CONSTRAINT [CK_ProductReviews_Rating] CHECK ([Rating] >= 1 AND [Rating] <= 5)
)
-- Add some exciting sample reviews
INSERT INTO [Operation].[ProductReviews] (ProductID, CustomerID, Rating, ReviewTitle, ReviewText, IsVerifiedPurchase)
VALUES 
(1, 'ALFKI', 5, 'Amazing iPhone!', 'The iPhone 15 Pro is absolutely fantastic! Camera quality is incredible and performance is blazing fast.', 1),
(2, 'ANATR', 4, 'Great Android Phone', 'Samsung Galaxy S24 is excellent. Love the display and battery life.', 1),
(4, 'ANTON', 5, 'Gaming Paradise!', 'PlayStation 5 is a game-changer! Graphics are mind-blowing and load times are super fast.', 1),
(6, 'AROUT', 5, 'Nintendo Magic', 'Switch OLED is perfect for gaming on the go. My kids love it!', 1),
(8, 'BERGS', 5, 'Must-read for developers!', 'The Pragmatic Programmer changed how I think about coding. Highly recommended!', 1)
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
    CONSTRAINT [PK_InventoryAudit] PRIMARY KEY CLUSTERED ([AuditID]),
    CONSTRAINT [FK_InventoryAudit_Products] FOREIGN KEY ([ProductID]) REFERENCES [Operation].[Products] ([ProductID])
)

PRINT N'✅ Product Reviews system implemented!' PRINT N'⭐ Customer reviews with 1-5 star ratings' PRINT N'📦 Inventory audit tracking added' PRINT N'🎯 Ready for customer engagement!'