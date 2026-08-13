CREATE PROCEDURE [dbo].[DW_MergeDimBook]
AS
BEGIN
    UPDATE target
    SET
        target.title = source.title,
        target.isbn13 = source.isbn13,
        target.num_pages = source.num_pages,
        target.publication_date = source.publication_date,
        target.language_name = source.language_name,
        target.publisher_name = source.publisher_name,
        target.authors = source.author_name
    FROM [dbo].[dim_book] AS target
    INNER JOIN [staging].[tmp_book_changes] AS source
        ON target.book_id = source.book_id;
END
GO