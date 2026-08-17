/*
Script de implementación para BookstoreDW

Este código lo generó una herramienta.
Los cambios en este archivo pueden provocar un comportamiento incorrecto y se perderán si
el código se vuelve a generar.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BookstoreDW"
:setvar DefaultFilePrefix "BookstoreDW"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.JORGE\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.JORGE\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detecte el modo SQLCMD y deshabilite la ejecución de scripts si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
ESTABLECER NOEXEC DESACTIVADO; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Quitando Índice [dbo].[dim_address].[uq_dim_address_address_id]...';


GO
DROP INDEX [uq_dim_address_address_id]
    ON [dbo].[dim_address];


GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimAddress]...';


GO
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
GO
PRINT N'Actualización completada.';


GO
