CREATE PROCEDURE [dbo].[DW_MergeDimAddress]
AS
BEGIN
    UPDATE target
    SET
        target.street_number = source.street_number,
        target.street_name   = source.street_name,
        target.city          = source.city,
        target.country_name  = source.country_name
    FROM [dbo].[dim_address] AS target
    INNER JOIN [staging].[stg_address] AS source
        ON target.address_id = source.address_id;
END