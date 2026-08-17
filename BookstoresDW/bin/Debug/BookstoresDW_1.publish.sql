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
PRINT N'Modificando Procedimiento [dbo].[DW_MergeDimBook]...';


GO
ALTER PROCEDURE [dbo].[DW_MergeDimBook]
AS
BEGIN
    UPDATE target
    SET
        target.title = source.title,
        target.isbn13 = source.isbn13,
        target.num_pages = source.num_pages,
        target.publication_date = source.publication_date,
        target.language_name = source.language_name,
        target.publisher_name = source.publisher_name,
        target.authors = source.author_name
    FROM [dbo].[dim_book] AS target
    INNER JOIN [staging].[tmp_book_changes] AS source
        ON target.book_id = source.book_id;
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimCustomer]...';


GO
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
PRINT N'Actualización completada.';


GO
