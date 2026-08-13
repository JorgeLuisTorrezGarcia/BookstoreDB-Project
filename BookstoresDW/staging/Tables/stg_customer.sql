CREATE TABLE [staging].[stg_customer] (
    [customer_id] INT           NOT NULL,
    [first_name]  VARCHAR (200) NULL,
    [last_name]   VARCHAR (200) NULL,
    [email]       VARCHAR (350) NULL,
    [street_name]  VARCHAR(200) NULL,
    [street_number]   VARCHAR(10) NULL,
    [city]            VARCHAR(100) NULL,
    [address_status]  VARCHAR(30) NULL,
    [country_name]    VARCHAR(200) NULL,
    [rowversion]  BINARY (8)    NULL
    CONSTRAINT [pk_stg_customer] PRIMARY KEY CLUSTERED ([customer_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_stg_customer_rowversion]
    ON [staging].[stg_customer]([rowversion] ASC);

