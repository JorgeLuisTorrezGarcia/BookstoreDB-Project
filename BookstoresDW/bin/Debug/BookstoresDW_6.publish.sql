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
/*
Se está quitando la columna [staging].[stg_sales].[shipping_address_ke]; puede que se pierdan datos.

Debe agregarse la columna [staging].[stg_sales].[shipping_address_key] de la tabla [staging].[stg_sales], pero esta columna no tiene un valor predeterminado y no admite valores NULL. Si la tabla contiene datos, el script ALTER no funcionará. Para evitar esta incidencia, agregue un valor predeterminado a la columna, márquela de modo que permita valores NULL o habilite la generación de valores predeterminados inteligentes como opción de implementación.
*/

IF EXISTS (select top 1 1 from [staging].[stg_sales])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'Quitando Restricción DEFAULT restricción sin nombre en [staging].[stg_sales]...';


GO
ALTER TABLE [staging].[stg_sales] DROP CONSTRAINT [DF__tmp_ms_xx__quant__02FC7413];


GO
PRINT N'Iniciando recompilación de la tabla [staging].[stg_sales]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [staging].[tmp_ms_xx_stg_sales] (
    [order_id]             INT             NOT NULL,
    [line_id]              INT             NOT NULL,
    [order_date_key]       INT             NOT NULL,
    [customer_key]         INT             NOT NULL,
    [book_key]             INT             NOT NULL,
    [shipping_address_key] INT             NOT NULL,
    [price]                DECIMAL (10, 2) NULL,
    [quantity]             INT             DEFAULT ((1)) NOT NULL,
    [rowversion]           BINARY (8)      NULL,
    [total_amount]         DECIMAL (10, 2) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_pk_stg_sales1] PRIMARY KEY CLUSTERED ([order_id] ASC, [line_id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [staging].[stg_sales])
    BEGIN
        INSERT INTO [staging].[tmp_ms_xx_stg_sales] ([order_id], [line_id], [order_date_key], [customer_key], [book_key], [price], [quantity], [rowversion], [total_amount])
        SELECT   [order_id],
                 [line_id],
                 [order_date_key],
                 [customer_key],
                 [book_key],
                 [price],
                 [quantity],
                 [rowversion],
                 [total_amount]
        FROM     [staging].[stg_sales]
        ORDER BY [order_id] ASC, [line_id] ASC;
    END

DROP TABLE [staging].[stg_sales];

EXECUTE sp_rename N'[staging].[tmp_ms_xx_stg_sales]', N'stg_sales';

EXECUTE sp_rename N'[staging].[tmp_ms_xx_constraint_pk_stg_sales1]', N'pk_stg_sales', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creando Índice [staging].[stg_sales].[idx_stg_sales_rowversion]...';


GO
CREATE NONCLUSTERED INDEX [idx_stg_sales_rowversion]
    ON [staging].[stg_sales]([rowversion] ASC);


GO
PRINT N'Actualización completada.';


GO
