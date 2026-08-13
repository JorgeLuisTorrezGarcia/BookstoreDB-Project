CREATE TABLE [dbo].[dim_book] (
    [book_key]         INT           IDENTITY (1, 1) NOT NULL,
    [book_id]          INT           NOT NULL,
    [title]            VARCHAR (400) NULL,
    [isbn13]           VARCHAR (13)  NULL,
    [num_pages]        INT           NULL,
    [publication_date] DATE          NULL,
    [language_name]    VARCHAR (50)  NULL,
    [publisher_name]   VARCHAR (400) NULL,
    [authors]          VARCHAR (MAX) NULL,
    CONSTRAINT [pk_dim_book] PRIMARY KEY CLUSTERED ([book_key] ASC)
);


GO


