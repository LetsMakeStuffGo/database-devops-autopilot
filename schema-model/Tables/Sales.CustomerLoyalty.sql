CREATE TABLE [Sales].[CustomerLoyalty]
(
[CustomerID] [nchar] (5) NOT NULL,
[TotalPoints] [int] NOT NULL CONSTRAINT [DF__CustomerL__Total__1EA48E88] DEFAULT ((0)),
[LoyaltyLevel] [nvarchar] (20) NOT NULL CONSTRAINT [DF__CustomerL__Loyal__1F98B2C1] DEFAULT ('Bronze'),
[JoinDate] [datetime] NOT NULL CONSTRAINT [DF__CustomerL__JoinD__208CD6FA] DEFAULT (getdate()),
[LastPointUpdate] [datetime] NULL
)
GO
ALTER TABLE [Sales].[CustomerLoyalty] ADD CONSTRAINT [PK_CustomerLoyalty] PRIMARY KEY CLUSTERED ([CustomerID])
GO
ALTER TABLE [Sales].[CustomerLoyalty] ADD CONSTRAINT [FK_CustomerLoyalty_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customers] ([CustomerID])
GO
