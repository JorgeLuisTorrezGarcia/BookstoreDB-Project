CREATE TABLE [dbo].[fact_sales] (
    [fact_id]              INT             IDENTITY (1, 1) NOT NULL,
    [order_date_key]       INT             NOT NULL,
    [customer_key]         INT             NOT NULL,
    [book_key]             INT             NOT NULL,
    [shipping_address_key] INT             NOT NULL,
    [order_id]             INT             NOT NULL,
    [line_id]              INT             NOT NULL,
    [price]                DECIMAL (10, 2) NOT NULL,
    [quantity]             INT             CONSTRAINT [df_fact_sales_quantity] DEFAULT ((1)) NOT NULL,
    [total_amount]         DECIMAL (10, 2) NOT NULL,
    CONSTRAINT [pk_fact_sales] PRIMARY KEY CLUSTERED ([fact_id] ASC),
    CONSTRAINT [fk_fact_sales_dim_address] FOREIGN KEY ([shipping_address_key]) REFERENCES [dbo].[dim_address] ([address_key]),
    CONSTRAINT [fk_fact_sales_dim_book] FOREIGN KEY ([book_key]) REFERENCES [dbo].[dim_book] ([book_key]),
    CONSTRAINT [fk_fact_sales_dim_customer] FOREIGN KEY ([customer_key]) REFERENCES [dbo].[dim_customer] ([customer_key]),
    CONSTRAINT [fk_fact_sales_dim_date] FOREIGN KEY ([order_date_key]) REFERENCES [dbo].[dim_date] ([DateKey])
);


GO
CREATE NONCLUSTERED INDEX [idx_fact_sales_order_date]
    ON [dbo].[fact_sales]([order_date_key] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_fact_sales_customer]
    ON [dbo].[fact_sales]([customer_key] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_fact_sales_book]
    ON [dbo].[fact_sales]([book_key] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_fact_sales_address]
    ON [dbo].[fact_sales]([shipping_address_key] ASC);

