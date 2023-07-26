-- Datagen to Delta
INSERT INTO delta_datagen_data
 SELECT s.* FROM default_catalog.default_database.datagen AS s;

-- Datagen to Hudi
INSERT INTO default_catalog.default_database.hudi_datagen_data
 SELECT s.* FROM default_catalog.default_database.datagen AS s;

-- Oracle to Delta
INSERT INTO delta_sample_data
 SELECT s.* FROM default_catalog.default_database.sample_data AS s;

-- Oracle to Hudi
SET 'execution.checkpointing.interval' = '3s'; 
INSERT INTO default_catalog.default_database.hudi_sample_data
 SELECT s.* FROM default_catalog.default_database.sample_data AS s;