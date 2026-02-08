CREATE PROCEDURE sp_UpsertVenue
    @VenueId INT = NULL, -- Optional parameter
    @Name NVARCHAR(100),
    @City NVARCHAR(100),
    @Capacity INT,
    @BasePrice DECIMAL(18,2),
    @ImageUrl NVARCHAR(MAX)
AS
BEGIN
    IF @VenueId IS NULL OR @VenueId = 0
    BEGIN
        -- INSERT Mode
        INSERT INTO Venues (Name, City, Capacity, BasePrice, ImageUrl, IsAvailable)
        VALUES (@Name, @City, @Capacity, @BasePrice, @ImageUrl, 1);
    END
    ELSE
    BEGIN
        -- UPDATE Mode
        UPDATE Venues 
        SET Name = @Name, City = @City, Capacity = @Capacity, 
            BasePrice = @BasePrice, ImageUrl = @ImageUrl
        WHERE VenueId = @VenueId;
    END
END