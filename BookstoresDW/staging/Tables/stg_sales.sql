CREATE TABLE [staging].[stg_sales] (
    [order_id]        INT             NOT NULL,
    [line_id]         INT             NOT NULL,
    [order_date]      DATETIME        NULL,
    [customer_id]     INT             NULL,
    [book_id]         INT             NULL,
    [dest_address_id] INT             NULL,
    [price]           DECIMAL (10, 2) NULL,
    [quantity]        INT             DEFAULT ((1)) NOT NULL,
    [rowversion]      BINARY (8)      NULL,
    CONSTRAINT [pk_stg_sales] PRIMARY KEY CLUSTERED ([order_id] ASC, [line_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_stg_sales_rowversion]
    ON [staging].[stg_sales]([rowversion] ASC);

