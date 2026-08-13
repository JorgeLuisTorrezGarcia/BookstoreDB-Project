CREATE TABLE [staging].[stg_address] (
    [address_id]    INT           NOT NULL,
    [street_number] VARCHAR (10)  NULL,
    [street_name]   VARCHAR (200) NULL,
    [city]          VARCHAR (100) NULL,
    [country_name]  VARCHAR (200) NULL,
    [rowversion]    BINARY (8)    NULL,
    CONSTRAINT [pk_stg_address] PRIMARY KEY CLUSTERED ([address_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_stg_address_rowversion]
    ON [staging].[stg_address]([rowversion] ASC);

