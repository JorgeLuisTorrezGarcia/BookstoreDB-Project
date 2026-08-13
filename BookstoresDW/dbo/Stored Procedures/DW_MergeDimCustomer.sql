CREATE PROCEDURE dbo.DW_MergeDimCustomer
AS
BEGIN
    UPDATE target
    SET 
        target.first_name = source.first_name,
        target.last_name  = source.last_name,
        target.email      = source.email
    FROM dbo.dim_customer AS target
    INNER JOIN staging.stg_customer AS source
        ON target.customer_id = source.customer_id;
END
GO