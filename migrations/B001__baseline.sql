/* =========================================================================
Flyway AutoPilot Training - Baseline Migration (SQL Server)
Purpose: Establish starting e-commerce schema, seed data, views & procs
Notes:
- Uses GO batch separators (required for VIEW/PROC creation).
- Sets session options at start and again before VIEW/PROC.
- Designed to run once as a versioned baseline.
========================================================================= */

-- Session options
SET NUMERIC_ROUNDABORT OFF;

SET ANSI_PADDING ON;

SET ANSI_WARNINGS ON;

SET CONCAT_NULL_YIELDS_NULL ON;

SET ARITHABORT ON;

SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS ON;

PRINT N'Creating business schemas...';
GO

-- Create schemas (idempotent)
IF SCHEMA_ID (N'Customers') IS NULL EXEC sp_executesql N'CREATE SCHEMA [Customers]  AUTHORIZATION [dbo]';

IF SCHEMA_ID (N'Sales') IS NULL EXEC sp_executesql N'CREATE SCHEMA [Sales]      AUTHORIZATION [dbo]';

IF SCHEMA_ID (N'Logistics') IS NULL EXEC sp_executesql N'CREATE SCHEMA [Logistics]  AUTHORIZATION [dbo]';

IF SCHEMA_ID (N'Operation') IS NULL EXEC sp_executesql N'CREATE SCHEMA [Operation]  AUTHORIZATION [dbo]';
GO

PRINT N'Creating core tables...';
GO

-- Customers table
IF OBJECT_ID(N'[Sales].[Customers]', N'U') IS NULL
BEGIN
    CREATE TABLE [Sales].[Customers]
    (
        [CustomerID]   nchar(5)       NOT NULL,
        [CompanyName]  nvarchar(40)   NOT NULL,
        [ContactName]  nvarchar(30)   NULL,
        [ContactTitle] nvarchar(30)   NULL,
        [Address]      nvarchar(60)   NULL,
        [City]         nvarchar(15)   NULL,
        [Region]       nvarchar(15)   NULL,
        [PostalCode]   nvarchar(10)   NULL,
        [Country]      nvarchar(15)   NULL,
        [Phone]        nvarchar(24)   NULL,
        [Fax]          nvarchar(24)   NULL,
        CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerID])
    );

END

-- Categories
IF OBJECT_ID(N'[Operation].[Categories]', N'U') IS NULL
BEGIN
    CREATE TABLE [Operation].[Categories]
    (
        [CategoryID]   int             IDENTITY(1,1) NOT NULL,
        [CategoryName] nvarchar(15)    NOT NULL,
        [Description]  nvarchar(max)   NULL,   -- (ntext deprecated)
        CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryID])
    );

END

-- Products
IF OBJECT_ID(N'[Operation].[Products]', N'U') IS NULL
BEGIN
    CREATE TABLE [Operation].[Products]
    (
        [ProductID]     int            IDENTITY(1,1) NOT NULL,
        [ProductName]   nvarchar(40)   NOT NULL,
        [CategoryID]    int            NULL,
        [UnitPrice]     money          NULL CONSTRAINT [DF_Products_UnitPrice] DEFAULT (0),
        [UnitsInStock]  smallint       NULL CONSTRAINT [DF_Products_UnitsInStock] DEFAULT (0),
        [Discontinued]  bit            NOT NULL CONSTRAINT [DF_Products_Discontinued] DEFAULT (0),
        CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([ProductID]),
        CONSTRAINT [FK_Products_Categories] FOREIGN KEY ([CategoryID])
            REFERENCES [Operation].[Categories]([CategoryID])
    );

END

-- Orders
IF OBJECT_ID(N'[Sales].[Orders]', N'U') IS NULL
BEGIN
    CREATE TABLE [Sales].[Orders]
    (
        [OrderID]      int            IDENTITY(1,1) NOT NULL,
        [CustomerID]   nchar(5)       NULL,
        [OrderDate]    datetime       NULL,
        [RequiredDate] datetime       NULL,
        [ShippedDate]  datetime       NULL,
        [Freight]      money          NULL CONSTRAINT [DF_Orders_Freight] DEFAULT (0),
        [ShipName]     nvarchar(40)   NULL,
        [ShipCity]     nvarchar(15)   NULL,
        [ShipCountry]  nvarchar(15)   NULL,
        CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID]),
        CONSTRAINT [FK_Orders_Customers] FOREIGN KEY ([CustomerID])
            REFERENCES [Sales].[Customers]([CustomerID])
    );

END

PRINT N'Seeding reference and sample data...';
GO

-- Seed Categories (idempotent-ish: insert if not exists)
IF NOT EXISTS (SELECT 1 FROM [Operation].[Categories])
BEGIN
    INSERT INTO [Operation].[Categories] ([CategoryName], [Description]) VALUES
    (N'Electronics',      N'Cutting-edge gadgets and tech devices'),
    (N'Gaming',           N'Latest games and gaming accessories'),
    (N'Books',            N'Educational and entertainment literature'),
    (N'Sports',           N'Sports equipment and outdoor gear'),
    (N'Home & Garden',    N'Everything for your home and garden');

END

-- Seed Customers
IF NOT EXISTS (SELECT 1 FROM [Sales].[Customers] WHERE [CustomerID] = N'ALFKI')
BEGIN
    INSERT INTO [Sales].[Customers]
    ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [City], [Country], [Phone]) VALUES
    (N'ALFKI', N'Alfreds Futterkiste', N'Maria Anders', N'Sales Representative', N'Berlin',       N'Germany', N'030-0074321'),
    (N'ANATR', N'Ana Trujillo Emparedados y helados', N'Ana Trujillo', N'Owner', N'México D.F.',  N'Mexico',  N'(5) 555-4729'),
    (N'ANTON', N'Antonio Moreno Taquería', N'Antonio Moreno', N'Owner', N'México D.F.',          N'Mexico',  N'(5) 555-3932'),
    (N'AROUT', N'Around the Horn', N'Thomas Hardy', N'Sales Representative', N'London',           N'UK',      N'(171) 555-7788'),
    (N'BERGS', N'Berglunds snabbköp', N'Christina Berglund', N'Order Administrator', N'Luleå',     N'Sweden',  N'0921-12 34 65'),
    (N'BLAUS', N'Blauer See Delikatessen', N'Hanna Moos', N'Sales Representative', N'Mannheim',    N'Germany', N'0621-08460'),
    (N'BOLID', N'Bólido Comidas preparadas', N'Martín Sommer', N'Owner', N'Madrid',               N'Spain',   N'(91) 555 22 82'),
    (N'BONAP', N'Bon app''', N'Laurence Lebihan', N'Owner', N'Marseille',                          N'France',  N'91.24.45.40');

END

-- Seed Products
IF NOT EXISTS (SELECT 1 FROM [Operation].[Products])
BEGIN
    INSERT INTO [Operation].[Products] ([ProductName], [CategoryID], [UnitPrice], [UnitsInStock]) VALUES
    (N'iPhone 15 Pro',           1, 1199.00, 25),
    (N'Samsung Galaxy S24',      1,  999.00, 30),
    (N'MacBook Air M3',          1, 1299.00, 15),
    (N'PlayStation 5',           2,  499.00, 20),
    (N'Xbox Series X',           2,  499.00, 18),
    (N'Nintendo Switch OLED',    2,  349.00, 35),
    (N'Cyberpunk 2077',          2,   59.99,100),
    (N'The Pragmatic Programmer',3,   39.99, 50),
    (N'Clean Code',              3,   34.99, 45),
    (N'Wilson Tennis Racket',    4,   89.99, 25),
    (N'Nike Running Shoes',      4,  129.99, 40),
    (N'Smart Garden Kit',        5,  199.99, 12);

END

-- Seed Orders
IF NOT EXISTS (SELECT 1 FROM [Sales].[Orders])
BEGIN
    INSERT INTO [Sales].[Orders]
    ([CustomerID], [OrderDate], [RequiredDate], [ShipName], [ShipCity], [ShipCountry], [Freight]) VALUES
    (N'ALFKI', '2024-01-15T00:00:00', '2024-01-25T00:00:00', N'Alfreds Futterkiste',                 N'Berlin',     N'Germany', 32.38),
    (N'ANATR', '2024-01-20T00:00:00', '2024-02-01T00:00:00', N'Ana Trujillo Emparedados y helados',  N'México D.F.',N'Mexico',  11.61),
    (N'ANTON', '2024-01-22T00:00:00', '2024-02-05T00:00:00', N'Antonio Moreno Taquería',             N'México D.F.',N'Mexico',  65.83),
    (N'AROUT', '2024-02-01T00:00:00', '2024-02-15T00:00:00', N'Around the Horn',                     N'London',     N'UK',      41.34),
    (N'BERGS', '2024-02-05T00:00:00', '2024-02-20T00:00:00', N'Berglunds snabbköp',                  N'Luleå',      N'Sweden',  55.09);

END

PRINT N'Creating reporting views...';
GO

-- Views must be first in batch; set options again
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS ON;
GO
CREATE OR ALTER VIEW [Sales].[CustomerOrdersSummary]
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
CREATE OR ALTER VIEW [Operation].[ProductInventoryStatus]
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

PRINT N'Creating stored procedures...';
GO

-- Procedures must be first in batch; set options again
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS ON;
GO
CREATE OR ALTER PROCEDURE [Customers].[AddCustomerFeedback]
    @CustomerID nchar(5),
    @Rating     int,
    @Comments   nvarchar(500)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Rating < 1 OR @Rating > 5
    BEGIN
        RAISERROR(N'Rating must be between 1 and 5', 16, 1);
        RETURN;
    END;

    -- Placeholder behaviour for baseline
    PRINT N'Customer ' + @CustomerID
        + N' gave rating: ' + CAST(@Rating AS nvarchar(10))
        + N' with comments: ' + ISNULL(@Comments, N'No comments');
    PRINT N'Feedback recorded (placeholder).';
END
GO

SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS ON;
GO
CREATE OR ALTER PROCEDURE [Operation].[UpdateProductStock]
    @ProductID int,
    @Quantity  int,
    @Operation varchar(10) -- 'ADD' or 'SUBTRACT'
AS
BEGIN
    SET NOCOUNT ON;

    IF UPPER(@Operation) = 'ADD'
    BEGIN
        UPDATE [Operation].[Products]
            SET UnitsInStock = UnitsInStock + @Quantity
        WHERE ProductID = @ProductID;
    END
    ELSE IF UPPER(@Operation) = 'SUBTRACT'
    BEGIN
        UPDATE [Operation].[Products]
            SET UnitsInStock = CASE WHEN UnitsInStock >= @Quantity
                                    THEN UnitsInStock - @Quantity
                                    ELSE 0 END
        WHERE ProductID = @ProductID;
    END
    ELSE
    BEGIN
        RAISERROR(N'Operation must be ADD or SUBTRACT', 16, 1);
    END
END
GO

PRINT N'Baseline migration completed: schemas, tables, seed data, views, and procedures created.';
GO