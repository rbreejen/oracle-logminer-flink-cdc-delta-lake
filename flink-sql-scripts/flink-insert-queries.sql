-- Datagen to Delta
INSERT INTO delta_datagen_data
 SELECT s.* FROM default_catalog.default_database.datagen AS s;

-- Datagen to Hudi
INSERT INTO default_catalog.default_database.hudi_datagen_data
 SELECT s.* FROM default_catalog.default_database.datagen AS s;