CREATE TABLE [users] (
  [user_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [first_name] varchar(50) NOT NULL,
  [last_name] varchar(50) NOT NULL,
  [contact_id] integer NOT NULL
)
GO

CREATE TABLE [user_roles] (
  [user_id] integer NOT NULL,
  [role_id] integer NOT NULL,
  [supply_chain_type_id] integer NOT NULL,
  [supply_chain_entity_id] uniqueidentifier NOT NULL,
  PRIMARY KEY ([user_id], [role_id])
)
GO

CREATE TABLE [roles] (
  [role_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [role] varchar(50) NOT NULL
)
GO

CREATE TABLE [supply_chain_type] (
  [type_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [name] varchar(20) NOT NULL
)
GO

CREATE TABLE [addresses] (
  [address_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [street_number] varchar(10),
  [street_name] varchar(150) NOT NULL,
  [suburb_id] integer NOT NULL,
  [city_id] integer NOT NULL
)
GO

CREATE TABLE [suburb] (
  [suburb_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [name] varchar(150) NOT NULL,
  [postal_code] varchar(15) NOT NULL
)
GO

CREATE TABLE [city] (
  [city_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [name] varchar(150) NOT NULL,
  [province_id] integer NOT NULL
)
GO

CREATE TABLE [province] (
  [province_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [name] varchar(150) NOT NULL,
  [country_id] integer NOT NULL
)
GO

CREATE TABLE [country] (
  [country_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [name] varchar(150) NOT NULL
)
GO

CREATE TABLE [contact_details] (
  [contact_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1)
)
GO

CREATE TABLE [phone_numbers] (
  [phone_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [phone_number] varchar(15) NOT NULL,
  [contact_id] integer NOT NULL
)
GO

CREATE TABLE [emails] (
  [email_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [email] varchar(320) NOT NULL,
  [contact_id] integer NOT NULL
)
GO

CREATE TABLE [farms] (
  [farm_id] uniqueidentifier PRIMARY KEY NOT NULL,
  [name] varchar(150) NOT NULL,
  [description] text,
  [address_id] integer NOT NULL,
  [contact_id] integer NOT NULL
)
GO

CREATE TABLE [harvests] (
  [harvest_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [harvest_date] date NOT NULL,
  [weight_kg] float NOT NULL,
  [farm_id] uniqueidentifier NOT NULL,
  [bean_id] integer NOT NULL,
  [shipment_id] integer
)
GO

CREATE TABLE [bean_types] (
  [bean_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [name] varchar(100) NOT NULL
)
GO

CREATE TABLE [manufacturers] (
  [manufacturer_id] uniqueidentifier PRIMARY KEY NOT NULL,
  [name] varchar(150) NOT NULL,
  [address_id] integer NOT NULL,
  [contact_id] integer NOT NULL,
  [manufacturer_type_id] integer NOT NULL
)
GO

CREATE TABLE [manufacturer_types] (
  [manufacturer_type_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [manufacturer_type] varchar(100) NOT NULL,
  [manufacturer_service] text
)
GO

CREATE TABLE [batches] (
  [batch_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [batch_weight_kg] float NOT NULL,
  [harvest_id] integer NOT NULL,
  [manufacturer_id] uniqueidentifier NOT NULL,
  [manufactured_date] date,
  [shipment_id] integer,
  [warehouse_id] integer
)
GO

CREATE TABLE [losses] (
  [loss_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [batch_id] integer NOT NULL,
  [quantity] integer NOT NULL,
  [cause] text NOT NULL
)
GO

CREATE TABLE [warehouses] (
  [warehouse_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [name] varchar(150) NOT NULL,
  [address_id] integer NOT NULL,
  [contact_id] integer NOT NULL
)
GO

CREATE TABLE [shipments] (
  [shipment_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [departure_date] date NOT NULL,
  [arrival_date] date,
  [to_type_id] integer NOT NULL,
  [to_supply_chain_entity_id] uniqueidentifier NOT NULL
)
GO

CREATE TABLE [retailers] (
  [retailer_id] uniqueidentifier PRIMARY KEY NOT NULL,
  [name] varchar(150) NOT NULL,
  [address_id] integer NOT NULL,
  [contact_id] integer NOT NULL,
  [retailer_type_id] integer NOT NULL
)
GO

CREATE TABLE [retailer_types] (
  [retailer_type_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [retailer_type] varchar(100) NOT NULL
)
GO

ALTER TABLE [user_roles] ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id])
GO

ALTER TABLE [users] ADD FOREIGN KEY ([contact_id]) REFERENCES [contact_details] ([contact_id])
GO

ALTER TABLE [user_roles] ADD FOREIGN KEY ([role_id]) REFERENCES [roles] ([role_id])
GO

ALTER TABLE [user_roles] ADD FOREIGN KEY ([supply_chain_type_id]) REFERENCES [supply_chain_type] ([type_id])
GO

ALTER TABLE [addresses] ADD FOREIGN KEY ([suburb_id]) REFERENCES [suburb] ([suburb_id])
GO

ALTER TABLE [addresses] ADD FOREIGN KEY ([city_id]) REFERENCES [city] ([city_id])
GO

ALTER TABLE [city] ADD FOREIGN KEY ([province_id]) REFERENCES [province] ([province_id])
GO

ALTER TABLE [province] ADD FOREIGN KEY ([country_id]) REFERENCES [country] ([country_id])
GO

ALTER TABLE [phone_numbers] ADD FOREIGN KEY ([contact_id]) REFERENCES [contact_details] ([contact_id])
GO

ALTER TABLE [emails] ADD FOREIGN KEY ([contact_id]) REFERENCES [contact_details] ([contact_id])
GO

ALTER TABLE [user_roles] ADD FOREIGN KEY ([supply_chain_entity_id]) REFERENCES [farms] ([farm_id])
GO

ALTER TABLE [farms] ADD FOREIGN KEY ([address_id]) REFERENCES [addresses] ([address_id])
GO

ALTER TABLE [farms] ADD FOREIGN KEY ([contact_id]) REFERENCES [contact_details] ([contact_id])
GO

ALTER TABLE [harvests] ADD FOREIGN KEY ([farm_id]) REFERENCES [farms] ([farm_id])
GO

ALTER TABLE [harvests] ADD FOREIGN KEY ([bean_id]) REFERENCES [bean_types] ([bean_id])
GO

ALTER TABLE [harvests] ADD FOREIGN KEY ([shipment_id]) REFERENCES [shipments] ([shipment_id])
GO

ALTER TABLE [user_roles] ADD FOREIGN KEY ([supply_chain_entity_id]) REFERENCES [manufacturers] ([manufacturer_id])
GO

ALTER TABLE [shipments] ADD FOREIGN KEY ([to_supply_chain_entity_id]) REFERENCES [manufacturers] ([manufacturer_id])
GO

ALTER TABLE [manufacturers] ADD FOREIGN KEY ([address_id]) REFERENCES [addresses] ([address_id])
GO

ALTER TABLE [manufacturers] ADD FOREIGN KEY ([contact_id]) REFERENCES [contact_details] ([contact_id])
GO

ALTER TABLE [manufacturers] ADD FOREIGN KEY ([manufacturer_type_id]) REFERENCES [manufacturer_types] ([manufacturer_type_id])
GO

ALTER TABLE [batches] ADD FOREIGN KEY ([harvest_id]) REFERENCES [harvests] ([harvest_id])
GO

ALTER TABLE [batches] ADD FOREIGN KEY ([manufacturer_id]) REFERENCES [manufacturers] ([manufacturer_id])
GO

ALTER TABLE [batches] ADD FOREIGN KEY ([shipment_id]) REFERENCES [shipments] ([shipment_id])
GO

ALTER TABLE [batches] ADD FOREIGN KEY ([warehouse_id]) REFERENCES [warehouses] ([warehouse_id])
GO

ALTER TABLE [losses] ADD FOREIGN KEY ([batch_id]) REFERENCES [batches] ([batch_id])
GO

ALTER TABLE [warehouses] ADD FOREIGN KEY ([address_id]) REFERENCES [addresses] ([address_id])
GO

ALTER TABLE [warehouses] ADD FOREIGN KEY ([contact_id]) REFERENCES [contact_details] ([contact_id])
GO

ALTER TABLE [shipments] ADD FOREIGN KEY ([to_type_id]) REFERENCES [supply_chain_type] ([type_id])
GO

ALTER TABLE [user_roles] ADD FOREIGN KEY ([supply_chain_entity_id]) REFERENCES [retailers] ([retailer_id])
GO

ALTER TABLE [shipments] ADD FOREIGN KEY ([to_supply_chain_entity_id]) REFERENCES [retailers] ([retailer_id])
GO

ALTER TABLE [retailers] ADD FOREIGN KEY ([address_id]) REFERENCES [addresses] ([address_id])
GO

ALTER TABLE [retailers] ADD FOREIGN KEY ([contact_id]) REFERENCES [contact_details] ([contact_id])
GO

ALTER TABLE [retailers] ADD FOREIGN KEY ([retailer_type_id]) REFERENCES [retailer_types] ([retailer_type_id])
GO
