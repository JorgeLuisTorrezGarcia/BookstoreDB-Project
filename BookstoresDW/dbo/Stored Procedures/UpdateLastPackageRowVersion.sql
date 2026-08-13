CREATE   PROCEDURE [dbo].[UpdateLastPackageRowVersion]
    @TableName     VARCHAR(50),
    @LastRowVersion BIGINT
AS
BEGIN
    UPDATE [dbo].[PackageConfig]
    SET LastRowVersion = @LastRowVersion
    WHERE TableName = @TableName;

    IF @@ROWCOUNT = 0
    BEGIN
        INSERT INTO [dbo].[PackageConfig] (TableName, LastRowVersion)
        VALUES (@TableName, @LastRowVersion);
    END
END