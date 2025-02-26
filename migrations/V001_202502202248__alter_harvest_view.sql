ALTER VIEW [vw_harvests_inventory] AS
SELECT 
    batches.manufacturer_id AS manufacturer_id,
    harvests.harvest_id,
    (harvests.weight_kg - COALESCE(SUM(batches.batch_weight_kg), 0)) AS remaining_weight
FROM 
    harvests
LEFT JOIN 
    batches ON batches.harvest_id = harvests.harvest_id
GROUP BY 
    batches.manufacturer_id, harvests.harvest_id, harvests.weight_kg;
GO


