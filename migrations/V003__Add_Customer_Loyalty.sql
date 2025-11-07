-- 🌟 V003: Customer Loyalty Program Enhancement
-- Adding exciting customer loyalty features to boost engagement!

SET NUMERIC_ROUNDABORT OFF

SET
    ANSI_PADDING,
    ANSI_WARNINGS,
    CONCAT_NULL_YIELDS_NULL,
    ARITHABORT,
    QUOTED_IDENTIFIER,
    ANSI_NULLS ON

PRINT N'🌟 Adding Customer Loyalty Program...'

-- Create Customer Loyalty Points table
CREATE TABLE [Sales].[CustomerLoyalty]
(
    [CustomerID] [nchar](5) NOT NULL,
    [TotalPoints] [int] NOT NULL DEFAULT (0),
    [LoyaltyLevel] [nvarchar](20) NOT NULL DEFAULT ('Bronze'),
    [JoinDate] [datetime] NOT NULL DEFAULT (GETDATE()),
    [LastPointUpdate] [datetime] NULL,
    CONSTRAINT [PK_CustomerLoyalty] PRIMARY KEY CLUSTERED ([CustomerID]),
    CONSTRAINT [FK_CustomerLoyalty_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customers] ([CustomerID])
)

-- Add loyalty points for existing customers based on their order history
INSERT INTO [Sales].[CustomerLoyalty] (CustomerID, TotalPoints, LoyaltyLevel, LastPointUpdate)
SELECT 
    c.CustomerID,
    ISNULL(COUNT(o.OrderID) * 10, 0) as TotalPoints,
    CASE 
        WHEN COUNT(o.OrderID) >= 10 THEN 'Platinum'
        WHEN COUNT(o.OrderID) >= 5 THEN 'Gold'
        WHEN COUNT(o.OrderID) >= 2 THEN 'Silver'
        ELSE 'Bronze'
    END as LoyaltyLevel,
    MAX(o.OrderDate) as LastPointUpdate
FROM [Sales].[Customers] c
LEFT JOIN [Sales].[Orders] o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID

PRINT N'✅ Customer Loyalty Program implemented!' PRINT N'🎯 Loyalty levels: Bronze → Silver → Gold → Platinum' PRINT N'💰 Points awarded: 10 points per order'