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
PRINT N'Modificando Tabla [dbo].[dim_customer]...';


GO
ALTER TABLE [dbo].[dim_customer]
    ADD [street_name]    VARCHAR (200) NULL,
        [street_number]  VARCHAR (10)  NULL,
        [city]           VARCHAR (100) NULL,
        [address_status] VARCHAR (30)  NULL,
        [country_name]   VARCHAR (200) NULL;


GO
PRINT N'Iniciando recompilación de la tabla [staging].[stg_customer]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [staging].[tmp_ms_xx_stg_customer] (
    [customer_id]    INT           NOT NULL,
    [first_name]     VARCHAR (200) NULL,
    [last_name]      VARCHAR (200) NULL,
    [email]          VARCHAR (350) NULL,
    [street_name]    VARCHAR (200) NULL,
    [street_number]  VARCHAR (10)  NULL,
    [city]           VARCHAR (100) NULL,
    [address_status] VARCHAR (30)  NULL,
    [country_name]   VARCHAR (200) NULL,
    [rowversion]     BINARY (8)    NULL,
    CONSTRAINT [tmp_ms_xx_constraint_pk_stg_customer1] PRIMARY KEY CLUSTERED ([customer_id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [staging].[stg_customer])
    BEGIN
        INSERT INTO [staging].[tmp_ms_xx_stg_customer] ([customer_id], [first_name], [last_name], [email], [rowversion])
        SELECT   [customer_id],
                 [first_name],
                 [last_name],
                 [email],
                 [rowversion]
        FROM     [staging].[stg_customer]
        ORDER BY [customer_id] ASC;
    END

DROP TABLE [staging].[stg_customer];

EXECUTE sp_rename N'[staging].[tmp_ms_xx_stg_customer]', N'stg_customer';

EXECUTE sp_rename N'[staging].[tmp_ms_xx_constraint_pk_stg_customer1]', N'pk_stg_customer', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creando Índice [staging].[stg_customer].[idx_stg_customer_rowversion]...';


GO
CREATE NONCLUSTERED INDEX [idx_stg_customer_rowversion]
    ON [staging].[stg_customer]([rowversion] ASC);


GO
PRINT N'Actualizando Procedimiento [dbo].[DW_MergeDimCustomer]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[DW_MergeDimCustomer]';


GO
PRINT N'Actualización completada.';


GO
