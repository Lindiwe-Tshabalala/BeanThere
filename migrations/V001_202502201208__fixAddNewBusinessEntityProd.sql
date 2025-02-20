IF OBJECT_ID('Create_Business_Entity', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE Create_Business_Entity;
END;
GO

CREATE PROCEDURE Create_Business_Entity
    @entityType VARCHAR(50),
    @name VARCHAR(150),
    @street_number VARCHAR(50),
    @street_name VARCHAR(150),
    @suburb_name VARCHAR(150),
    @postal_code VARCHAR(15),
    @city_name VARCHAR(150),
    @province_name VARCHAR(150),
    @country_name VARCHAR(150),
	@phone_number VARCHAR(15),
	@email VARCHAR(320),
    @retailer_type VARCHAR(100) = NULL,
    @manufacturer_type VARCHAR(100) = NULL,
	@description TEXT = '',
    @manufacturer_service TEXT = ''
AS
BEGIN
    DECLARE @address_id INT,
            @contact_id INT,
            @retailer_type_id INT,
            @manufacturer_type_id INT,
            @business_id UNIQUEIDENTIFIER;

    IF @entityType IS NULL OR @name IS NULL
    BEGIN
        SELECT 'Error: entityType and name are required' AS ErrorMessage;
        RETURN;
    END;

    BEGIN TRY
        EXEC Create_Address 
            @street_number = @street_number,
            @street_name = @street_name,
            @suburb_name = @suburb_name,
            @postal_code = @postal_code,
            @city_name = @city_name,
            @province_name = @province_name,
            @country_name = @country_name,
            @address_id = @address_id OUTPUT;
    END TRY
    BEGIN CATCH
        SELECT 'Error: Failed to create address' AS ErrorMessage;
        RETURN;
    END CATCH;


    BEGIN TRANSACTION;
    BEGIN TRY
		INSERT INTO [contact_details] DEFAULT VALUES; 
		SET @contact_id = SCOPE_IDENTITY();

        SET @business_id = NEWID();

		INSERT INTO [emails] (email, contact_id)
		VALUES (@email, @contact_id);

		INSERT INTO [phone_numbers] (phone_number, contact_id)
		VALUES (@phone_number, @contact_id);

        IF @entityType = 'farm'
        BEGIN
            INSERT INTO [farms] (farm_id, name, description, address_id, contact_id)
            VALUES (@business_id, @name, @description, @address_id, @contact_id);
        END
        ELSE IF @entityType = 'retailer'
        BEGIN
            IF @retailer_type IS NOT NULL
            BEGIN
                SELECT @retailer_type_id = retailer_type_id 
                FROM retailer_types 
                WHERE retailer_type = @retailer_type;

                IF @retailer_type_id IS NULL
                BEGIN
                    INSERT INTO retailer_types (retailer_type) 
                    VALUES (@retailer_type);
                    SET @retailer_type_id = SCOPE_IDENTITY();
                END;
            END;

            INSERT INTO [retailers] (retailer_id, name, address_id, contact_id, retailer_type_id)
            VALUES (@business_id, @name, @address_id, @contact_id, @retailer_type_id);
        END
        ELSE IF @entityType = 'manufacturer'
        BEGIN
            IF @manufacturer_type IS NOT NULL
            BEGIN
                SELECT @manufacturer_type_id = manufacturer_type_id 
                FROM manufacturer_types 
                WHERE manufacturer_type = @manufacturer_type;

                IF @manufacturer_type_id IS NULL
                BEGIN
                    INSERT INTO [manufacturer_types] (manufacturer_type, manufacturer_service) 
                    VALUES (@manufacturer_type, @manufacturer_service);
                    SET @manufacturer_type_id = SCOPE_IDENTITY();
                END;
            END;

            INSERT INTO manufacturers (manufacturer_id, name, address_id, contact_id, manufacturer_type_id)
            VALUES (@business_id, @name, @address_id, @contact_id, @manufacturer_type_id);
        END
        ELSE
        BEGIN
            ROLLBACK TRANSACTION;
            SELECT 'Error: Invalid entityType' AS ErrorMessage;
            RETURN;
        END;

        COMMIT TRANSACTION;
        SELECT @business_id AS BusinessEntityID;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 'Error: Failed to create business entity' AS ErrorMessage;
    END CATCH;
END;
GO