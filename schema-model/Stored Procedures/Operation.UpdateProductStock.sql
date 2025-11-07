SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   PROCEDURE [Operation].[UpdateProductStock]
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
