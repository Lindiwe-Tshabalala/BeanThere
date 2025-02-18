CREATE FUNCTION dbo.fn_ShipmentsEntityExists (@entity_id UNIQUEIDENTIFIER)
RETURNS BIT
AS
BEGIN

    IF EXISTS (SELECT 1 FROM retailers WHERE retailer_id = @entity_id)
        RETURN 1;

    IF EXISTS (SELECT 1 FROM manufacturers WHERE manufacturer_id = @entity_id)
        RETURN 1;

    RETURN 0;
END;
GO
ALTER TABLE shipments ADD CONSTRAINT CK_Shipments_EntityExists CHECK (dbo.fn_ShipmentsEntityExists(to_supply_chain_entity_id) = 1);