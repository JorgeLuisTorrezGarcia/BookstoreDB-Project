CREATE   PROCEDURE [dbo].[GetLastPackageRowVersion]
    @TableName VARCHAR(50)
AS
BEGIN
    SELECT LastRowVersion
    FROM [dbo].[PackageConfig]
    WHERE TableName = @TableName;
END