-- execution modes
SET 'execution.runtime-mode' = 'streaming';
SET 'execution.runtime-mode' = 'batch';

-- The CLI supports three modes for maintaining and visualizing results.
-- https://nightlies.apache.org/flink/flink-docs-master/docs/dev/table/sqlclient/#sql-client-result-modes
SET 'sql-client.execution.result-mode' = 'table';
SET 'sql-client.execution.result-mode' = 'changelog';
SET 'sql-client.execution.result-mode' = 'tableau';

-- Print full exception stack for debugging
SET 'sql-client.verbose' = 'true';

-- Catalog information
-- https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/dev/table/catalogs/
show catalogs;
show databases;
show tables;