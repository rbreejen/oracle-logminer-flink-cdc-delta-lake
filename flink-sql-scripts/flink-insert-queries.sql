-- Datagen to Delta
INSERT INTO delta_datagen_data
 SELECT s.* FROM default_catalog.default_database.datagen AS s;

-- Datagen to Hudi
INSERT INTO default_catalog.default_database.hudi_datagen_data
 SELECT s.* FROM default_catalog.default_database.datagen AS s;

-- Currently it is not possible to write to a Delta table using Delta connector since only inserts are supported.
-- Flink CDC requires the sink to also support updates and deletes.
-- See: https://github.com/delta-io/connectors/tree/master/flink#sql-support
-- Postgres to Delta
-- INSERT INTO t_shipments_target
--  SELECT s.* FROM default_catalog.default_database.t_shipments_source AS s;

 -- Postgres to Hudi
INSERT INTO default_catalog.default_database.t_shipments_target
 SELECT s.* FROM default_catalog.default_database.t_shipments_source AS s;