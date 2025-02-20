CREATE VIEW [vw_all_entities] AS
SELECT farms.farm_id AS entity_id, 'Farm' AS entity_type, supply_chain_type.type_id
FROM farms
JOIN supply_chain_type ON supply_chain_type.name = 'Farm'

UNION ALL

SELECT manufacturers.manufacturer_id AS entity_id, 'Manufacturer' AS entity_type, supply_chain_type.type_id
FROM manufacturers
JOIN supply_chain_type ON supply_chain_type.name = 'Manufacturer'

UNION ALL

SELECT retailers.retailer_id AS entity_id, 'Retailer' AS entity_type, supply_chain_type.type_id
FROM retailers
JOIN supply_chain_type ON supply_chain_type.name = 'Retailer';
GO
