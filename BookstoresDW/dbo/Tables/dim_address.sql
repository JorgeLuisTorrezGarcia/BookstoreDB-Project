CREATE TABLE [dbo].[dim_address] (
    [address_key]   INT           IDENTITY (1, 1) NOT NULL,
    [address_id]    INT           NOT NULL,
    [street_number] VARCHAR (10)  NULL,
    [street_name]   VARCHAR (200) NULL,
    [city]          VARCHAR (100) NULL,
    [country_name]  VARCHAR (200) NULL,
    CONSTRAINT [pk_dim_address] PRIMARY KEY CLUSTERED ([address_key] ASC)
);


GO

