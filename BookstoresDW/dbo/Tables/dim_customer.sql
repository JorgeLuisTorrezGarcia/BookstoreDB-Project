CREATE TABLE [dbo].[dim_customer] (
    [customer_key] INT           IDENTITY (1, 1) NOT NULL,
    [customer_id]  INT           NOT NULL,
    [first_name]   VARCHAR (200) NULL,
    [last_name]    VARCHAR (200) NULL,
    [email]        VARCHAR (350) NULL,
    CONSTRAINT [pk_dim_customer] PRIMARY KEY CLUSTERED ([customer_key] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [uq_dim_customer_customer_id]
    ON [dbo].[dim_customer]([customer_id] ASC);

