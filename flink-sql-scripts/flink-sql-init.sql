CREATE TABLE datagen (
  f_sequence INT,
  f_random INT,
  f_random_str STRING,
  ts AS localtimestamp,
  WATERMARK FOR ts AS ts
) WITH (
  'connector' ='datagen',
  'rows-per-second'='5',
  'fields.f_sequence.kind'='sequence',
  'fields.f_sequence.start'='1',
  'fields.f_sequence.end'='1000',
  'fields.f_random.min'='1',
  'fields.f_random.max'='1000',
  'fields.f_random_str.length'='10'
); 

-- CREATE TABLE hudi_datagen_data (
--   f_sequence INT PRIMARY KEY NOT ENFORCED,
--   f_random INT,
--   f_random_str STRING,
--   ts TIMESTAMP
--   --WATERMARK FOR ts AS ts
-- ) WITH (
--       'connector' = 'hudi',
--       'write.tasks' = '4',
--       'path' = 's3a://lakehouse/datagen/hudi',
--       'table.type' = 'MERGE_ON_READ' --  MERGE_ON_READ table or, by default is COPY_ON_WRITE
-- );

CREATE TABLE sample_data (
    ID INT,
    CREATED_ON TIMESTAMP,
    RANDOM_NUMBER INT,
    PRIMARY KEY (ID) NOT ENFORCED
  ) WITH (
    'connector' = 'oracle-cdc',
    'hostname' = 'oracle',
    'port' = '1521',
    'username' = 'C##MYUSER',
    'password' = 'mypassword',
    'database-name' = 'XE',
    'schema-name' = 'DEBEZIUM',  
    'table-name' = 'SAMPLE_DATA',
    'debezium.database.pdb.name' = 'XEPDB1',
    -- 'debezium.log.mining.strategy' = 'online_catalog',
    -- 'debezium.log.mining.continuous.mine' = 'true',
    'scan.startup.mode' = 'latest-offset',
    'debezium.database.tablename.case.insensitive' = 'false'
  );

CREATE TABLE hudi_sample_data (
  ID INT PRIMARY KEY NOT ENFORCED,
  CREATED_ON DATE,
  RANDOM_NUMBER INT
  )
  WITH (
      'connector' = 'hudi',
      'write.tasks' = '4',
      'path' = 's3a://lakehouse/oracle/hudi',
      'table.type' = 'MERGE_ON_READ' --  MERGE_ON_READ table or, by default is COPY_ON_WRITE
);

-- CREATE CATALOG delta_catalog WITH (
--   'type' = 'delta-catalog',
--   'catalog-type' = 'in-memory'
-- );
-- USE CATALOG delta_catalog;

-- CREATE TABLE delta_datagen_data (
--   f_sequence INT,
--   f_random INT,
--   f_random_str STRING,
--   ts TIMESTAMP
--   --WATERMARK FOR ts AS ts
-- ) WITH (
--   'connector' = 'delta',
--   'table-path' = 's3a://lakehouse/datagen/delta'
-- );

-- CREATE TABLE delta_sample_data (
--   ID INT,
--   CREATED_ON DATE,
--   RANDOM_NUMBER INT
-- ) WITH (
--   'connector' = 'delta',
--   'table-path' = 's3a://lakehouse/oracle/delta'
-- );  
