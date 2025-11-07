SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   VIEW [Operation].[ProductInventoryStatus]
AS
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.UnitPrice,
    p.UnitsInStock,
    CASE 
        WHEN p.UnitsInStock = 0       THEN N'Out of Stock'
        WHEN p.UnitsInStock <= 10     THEN N'Low Stock'
        WHEN p.UnitsInStock <= 25     THEN N'Normal'
        ELSE                               N'Well Stocked'
    END AS StockStatus
FROM [Operation].[Products]   AS p
INNER JOIN [Operation].[Categories] AS c
    ON p.CategoryID = c.CategoryID
WHERE p.Discontinued = 0;
GO
