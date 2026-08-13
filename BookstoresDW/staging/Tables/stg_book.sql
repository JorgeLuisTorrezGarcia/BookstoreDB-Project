CREATE TABLE [staging].[stg_book] (
    [book_id]          INT           NOT NULL,
    [title]            VARCHAR (400) NULL,
    [isbn13]           VARCHAR (13)  NULL,
    [language_name]    VARCHAR (50)  NULL,
    [num_pages]        INT           NULL,
    [publication_date] DATE          NULL,
    [publisher_name]   VARCHAR (400) NULL,
    [rowversion]       BINARY (8)    NULL,
    CONSTRAINT [pk_stg_book] PRIMARY KEY CLUSTERED ([book_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_stg_book_rowversion]
    ON [staging].[stg_book]([rowversion] ASC);

