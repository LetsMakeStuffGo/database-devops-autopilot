SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   PROCEDURE [Customers].[AddCustomerFeedback]
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
