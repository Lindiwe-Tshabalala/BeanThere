INSERT INTO [country] (name) VALUES 
('USA'),
('Canada'),
('Mexico'),
('South Africa');

INSERT INTO [province] (name, country_id) VALUES 
('California', 1),
('Ontario', 2),
('Jalisco', 3),
('Western Cape', 4),
('Gauteng', 4);

INSERT INTO [city] (name, province_id) VALUES 
('Los Angeles', 1),
('Toronto', 2),
('Guadalajara', 3),
('Cape Town', 4),
('Johannesburg', 5);

INSERT INTO [suburb] (name, postal_code) VALUES 
('Hollywood', '90028'),
('Scarborough', 'M1E 1P1'),
('Zapopan', '45030'),
('Durbanville', '7550'),
('Kensington', '2094');

INSERT INTO [addresses] (street_number, street_name, suburb_id, city_id) VALUES 
('101', 'Sunset Blvd', 1, 1),
('250', 'King Street', 2, 2),
('555', 'Avenida López Mateos', 3, 3),
('12', 'Church Street', 4, 4),
('21', 'Kitchener Avenue', 5, 5);

INSERT INTO [contact_details] DEFAULT VALUES;
INSERT INTO [contact_details] DEFAULT VALUES;
INSERT INTO [contact_details] DEFAULT VALUES;
INSERT INTO [contact_details] DEFAULT VALUES;
INSERT INTO [contact_details] DEFAULT VALUES;
INSERT INTO [contact_details] DEFAULT VALUES;
INSERT INTO [contact_details] DEFAULT VALUES;

INSERT INTO [phone_numbers] (phone_number, contact_id) VALUES 
('123-456-7890', 1),
('987-654-3210', 2),
('213-543-3454', 3),
('345-123-3244', 4),
('235-543-654', 4),
('788-678-5676', 5),
('567-456-345', 6),
('234-654-765', 6),
('555-123-4567', 7);

INSERT INTO [emails] (email, contact_id) VALUES 
('user1@example.com', 1),
('user2@example.com', 2),
('user3@example.com', 3),
('user4@example.com', 4),
('user5@example.com', 5),
('user6@example.com', 6),
('user7@example.com', 7),
('user8@example.com', 7);

INSERT INTO [users] (first_name, last_name, contact_id) VALUES 
('Keith', 'Hughes', 1),
('Ryan', 'Christie', 2),
('Lindiwe', 'Tshabalala', 3);

INSERT INTO [roles] (role) VALUES 
('Admin'),
('Stock Manager'),
('Farmer');

INSERT INTO [supply_chain_type] (name) VALUES 
('Farm'),
('Manufacturer'),
('Retailer');

INSERT INTO [bean_types] (name) VALUES 
('Arabica'),
('Robusta'),
('Legume'),
('Cocoa')

INSERT INTO [farms] (farm_id, name, description, address_id, contact_id) VALUES 
('69408320-0D77-409C-8A4D-BBEA26879637', 'Green Valley', 'A farm that produces organic Arabica beans.', 1, 4);

INSERT INTO [manufacturer_types] (manufacturer_type, manufacturer_service) VALUES 
('Coffee Roaster', 'Roasting and packaging coffee beans');

INSERT INTO [manufacturers] (manufacturer_id, name, address_id, contact_id, manufacturer_type_id) VALUES 
('B9D1BA27-3756-4B3B-9E7B-DC25A29630FB', 'RoastMaster Co.', 2, 5, 1);

INSERT INTO [warehouses] (name, address_id, contact_id) VALUES 
('Super Storage', 3, 6);

INSERT INTO [shipments] (departure_date, arrival_date, to_type_id, to_supply_chain_entity_id) VALUES 
('2025-02-01', '2025-02-05', 2, 'B9D1BA27-3756-4B3B-9E7B-DC25A29630FB');

INSERT INTO harvests (harvest_date, weight_kg, farm_id, bean_id, shipment_id) VALUES 
('2025-02-01', 52, '69408320-0D77-409C-8A4D-BBEA26879637', 1, 1);

INSERT INTO [batches] (batch_weight_kg, harvest_id, manufacturer_id, manufactured_date, shipment_id, warehouse_id) VALUES 
(22, 1, 'B9D1BA27-3756-4B3B-9E7B-DC25A29630FB', '2025-02-10', 1, 1);

INSERT INTO [losses] (batch_id, quantity, cause) VALUES 
(1, 5, 'Spillage during transportation');

INSERT INTO [retailer_types] (retailer_type) VALUES 
('Cafe'), 
('Shop');

INSERT INTO [retailers] (retailer_id, name, address_id, contact_id, retailer_type_id) VALUES 
('C1F2C3D4-5678-9ABC-DEF0-123456789ABC', 'MyBrew', 4, 7, 1);

INSERT INTO [user_roles] (user_id, role_id, supply_chain_type_id, supply_chain_entity_id) VALUES 
(1, 3, 1, '69408320-0D77-409C-8A4D-BBEA26879637'),
(2, 2, 3, 'C1F2C3D4-5678-9ABC-DEF0-123456789ABC'),
(3, 1, 2, 'B9D1BA27-3756-4B3B-9E7B-DC25A29630FB');