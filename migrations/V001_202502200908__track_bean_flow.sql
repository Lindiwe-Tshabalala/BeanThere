CREATE FUNCTION dbo.fn_TrackBeanFlow (@bean_id INT)
RETURNS TABLE
AS
RETURN
(
    SELECT
        h.harvest_date,
        h.weight_kg AS harvested_weight_kg,
        bt.name AS bean_type,
        f.name AS farm_name,
        m.name AS manufacturer_name,
        w.name AS warehouse_name,
        r.name AS retailer_name,
        b.batch_weight_kg AS batch_weight_kg,
        s.departure_date,
        s.arrival_date
    FROM 
        harvests h
    JOIN 
        bean_types bt ON h.bean_id = bt.bean_id
    JOIN 
        farms f ON h.farm_id = f.farm_id
    LEFT JOIN 
        batches b ON h.harvest_id = b.harvest_id
    LEFT JOIN 
        manufacturers m ON b.manufacturer_id = m.manufacturer_id
    LEFT JOIN 
        warehouses w ON b.warehouse_id = w.warehouse_id
    LEFT JOIN 
        shipments s ON b.shipment_id = s.shipment_id
    LEFT JOIN 
        supply_chain_type st ON s.to_type_id = st.type_id
    LEFT JOIN 
        retailers r ON s.to_supply_chain_entity_id = r.retailer_id
    WHERE
        h.bean_id = @bean_id
);
GO
