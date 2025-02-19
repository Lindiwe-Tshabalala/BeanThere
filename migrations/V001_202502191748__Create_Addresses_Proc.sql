CREATE PROCEDURE Create_Address
    @street_number VARCHAR(10),
    @street_name VARCHAR(150),
    @suburb_name VARCHAR(150),
    @postal_code VARCHAR(15),
    @city_name VARCHAR(150),
    @province_name VARCHAR(150),
    @country_name VARCHAR(150),
    @address_id INT OUTPUT
AS
BEGIN
    DECLARE 
	    @suburb_id INT,
		@city_id INT, 
		@province_id INT, 
		@country_id INT;

    IF NOT EXISTS (SELECT 1 FROM country WHERE name = @country_name)
    BEGIN
        INSERT INTO country (name)
        VALUES (@country_name);
    END 
    SET @country_id = (SELECT country_id FROM country WHERE name = @country_name)

    IF NOT EXISTS (SELECT 1 FROM province WHERE name = @province_name AND country_id = @country_id)
    BEGIN
        INSERT INTO province (name, country_id)
        VALUES (@province_name, @country_id);
    END
    SET @province_id = (SELECT province_id FROM province WHERE name = @province_name AND country_id = @country_id);

    IF NOT EXISTS (SELECT 1 FROM city WHERE name = @city_name AND province_id = @province_id)
    BEGIN
        INSERT INTO city (name, province_id)
        VALUES (@city_name, @province_id);
    END
    SET @city_id = (SELECT city_id FROM city WHERE name = @city_name AND province_id = @province_id);

    IF NOT EXISTS (SELECT 1 FROM suburb WHERE name = @suburb_name AND postal_code = @postal_code)
    BEGIN
        INSERT INTO suburb (name, postal_code)
        VALUES (@suburb_name, @postal_code);
    END
    SET @suburb_id = (SELECT suburb_id FROM suburb WHERE name = @suburb_name AND postal_code = @postal_code);

    INSERT INTO addresses(street_number, street_name, suburb_id, city_id)
    VALUES (@street_number, @street_name, @suburb_id, @city_id);

	SET @address_id = SCOPE_IDENTITY()
END;
GO