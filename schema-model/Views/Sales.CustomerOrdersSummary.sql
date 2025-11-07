SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   VIEW [Sales].[CustomerOrdersSummary]
AS
SELECT 
    c.CustomerID,
    c.CompanyName,
    c.ContactName,
    c.City,
    c.Country,
    COUNT(o.OrderID)                 AS TotalOrders,
    ISNULL(SUM(o.Freight), 0)        AS TotalFreight
FROM [Sales].[Customers] AS c
LEFT JOIN [Sales].[Orders]    AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName, c.ContactName, c.City, c.Country;
GO
