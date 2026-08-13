CREATE TABLE [staging].[stg_book_author] (
    [book_id]     INT           NOT NULL,
    [author_id]   INT           NOT NULL,
    [author_name] VARCHAR (400) NULL,
    [rowversion]  BINARY (8)    NULL,
    CONSTRAINT [pk_stg_book_author] PRIMARY KEY CLUSTERED ([book_id] ASC, [author_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_stg_book_author_rowversion]
    ON [staging].[stg_book_author]([rowversion] ASC);

