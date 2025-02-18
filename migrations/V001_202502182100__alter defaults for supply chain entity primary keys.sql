ALTER TABLE manufacturers ADD CONSTRAINT DF_manufacturerid DEFAULT NEWID() FOR manufacturer_id;
ALTER TABLE retailers ADD CONSTRAINT DF_retailerid DEFAULT NEWID() FOR retailer_id;
ALTER TABLE farms ADD CONSTRAINT DF_farmid DEFAULT NEWID() FOR farm_id;

