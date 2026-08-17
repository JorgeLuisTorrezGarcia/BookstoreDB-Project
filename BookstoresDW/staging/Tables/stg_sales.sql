CREATE TABLE [staging].[stg_sales] (
    [order_id]        INT             NOT NULL,
    [line_id]         INT             NOT NULL,
    [order_date_key]  INT NOT NULL,
    [customer_key]     INT            NOT NULL,
    [book_key]         INT            NOT NULL,
    [shipping_address_key] INT         NOT NULL,
    [price]           DECIMAL (10, 2) NULL,
    [quantity]        INT             DEFAULT ((1)) NOT NULL,
    [rowversion]      BINARY (8)      NULL,
    [total_amount]    DECIMAL(10, 2)  NOT NULL,
    CONSTRAINT [pk_stg_sales] PRIMARY KEY CLUSTERED ([order_id] ASC, [line_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_stg_sales_rowversion]
    ON [staging].[stg_sales]([rowversion] ASC);

