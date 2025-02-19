

CREATE PROCEDURE Create_Shipment
    @ids_to_ship IdList READONLY, 
    @departure_date DATE,
    @arrival_date DATE = NULL,
    @to_type_id INT,
    @to_supply_chain_entity_id UNIQUEIDENTIFIER,
    @shipment_id INT OUTPUT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY 

        DECLARE @to_supply_chain_type_name VARCHAR(20); 

        SELECT @to_supply_chain_type_name = [name] 
        FROM supply_chain_type 
        WHERE @to_type_id = type_id;

        IF @to_supply_chain_type_name IS NULL OR dbo.fn_ShipmentsEntityExists(@to_supply_chain_entity_id) = 0
        BEGIN;
            THROW 50000, 'Invalid supply chain entity provided.', 1;
        END

        INSERT INTO shipments (departure_date, arrival_date, to_type_id, to_supply_chain_entity_id)
        VALUES (@departure_date, @arrival_date, @to_type_id, @to_supply_chain_entity_id);

        SET @shipment_id = SCOPE_IDENTITY()

        IF @to_supply_chain_type_name = 'Manufacturer'
        BEGIN
            UPDATE [harvests]
            SET shipment_id = @shipment_id
            WHERE harvest_id IN (SELECT id FROM @ids_to_ship);
        END

        IF @to_supply_chain_type_name = 'Retailer'
        BEGIN
            UPDATE [batches]
            SET shipment_id = @shipment_id
            WHERE batch_id IN (SELECT id FROM @ids_to_ship);
        END

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO