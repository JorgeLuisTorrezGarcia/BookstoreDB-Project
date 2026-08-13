CREATE TABLE [dbo].[dim_customer] (
    [customer_key] INT           IDENTITY (1, 1) NOT NULL,
    [customer_id]  INT           NOT NULL,
    [first_name]   VARCHAR (200) NULL,
    [last_name]    VARCHAR (200) NULL,
    [email]        VARCHAR (350) NULL,
    [street_name]  VARCHAR(200) NULL,
    [street_number]   VARCHAR(10) NULL,
    [city]            VARCHAR(100) NULL,
    [address_status]  VARCHAR(30) NULL,
    [country_name]    VARCHAR(200) NULL
    CONSTRAINT [pk_dim_customer] PRIMARY KEY CLUSTERED ([customer_key] ASC)
);


GO


