ALTER PROCEDURE Create_Batch
	@batch_weight_kg float,
	@harvest_id integer,
	@manufacturer_id uniqueidentifier,
	@warehouse_id integer = NULL,
	@batch_id INT OUTPUT
AS
BEGIN
	DECLARE @harvest_inventory float;
	DECLARE @to_manufacturer uniqueidentifier;

	SELECT @to_manufacturer = to_supply_chain_entity_id FROM shipments JOIN harvests ON harvests.[shipment_id] = shipments.[shipment_id]
	IF @to_manufacturer != @manufacturer_id
	BEGIN
		RAISERROR('The harvest does not belong to that manufacturer', 15, 2)
		RETURN
	END

	SELECT @harvest_inventory = remaining_weight FROM vw_harvests_inventory WHERE harvest_id = @harvest_id;

	IF @batch_weight_kg <= @harvest_inventory AND @batch_weight_kg > 0
	BEGIN
		INSERT INTO batches (batch_weight_kg, harvest_id, manufacturer_id, manufactured_date, warehouse_id)
		VALUES (@batch_weight_kg, @harvest_id, @manufacturer_id, CONVERT(DATE, GETDATE()), @warehouse_id);

		SET @batch_id = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		RAISERROR('Not enough harvest inventory for this batch weight or invalid weight provided', 15, 1)
	END
END;
GO