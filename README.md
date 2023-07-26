# WIP: Demo Oracle/Postgres to Delta Lake/Hudi using Flink CDC and Debezium standalone

An exploration of Flink and change-data-capture (CDC). 

```
docker-compose up --force-recreate
docker compose -f docker-compose.yaml -f docker-compose-oracle.yaml up --force-recreate
docker compose -f docker-compose.yaml -f docker-compose-postgres.yaml up --force-recreate --renew-anon-volumes
docker compose -f docker-compose-postgres-debezium.yaml up
```



In order to start the SQL Client run
```
docker compose run sql-client
```

## Requirements

Some dependencies are needed for the Flink application to work properly which entail some explanation

- `delta-flink1.16-bundle-1.0` - Fat jar with all [required](https://github.com/delta-io/connectors/tree/master/flink#usage) dependencies of Delta
- `hadoop-aws` (excl. `aws-java-sdk-bundle`), `flink-s3-fs-hadoop` (implicit `aws-java-sdk-s3`) - [Necessary](https://hudi.apache.org/docs/s3_hoodie/) dependencies for the integration between S3A and Hudi/Delta without the big fat `aws-java-sdk-bundle`.
- `hudi-flink1.16-bundle-0.13.1` - Package provided by Hudi developers, with all the [necessary](https://hudi.apache.org/docs/flink-quick-start-guide/#setup) dependencies to work with the technology.
- `flink-sql-connector-postgres-cdc-2.4.0` - Necessary dependencies for the integration between Postgres and Flink SQL CDC
- `flink-sql-connector-oracle-cdc-2.5-SNAPSHOT` - Necessary dependencies for the integration between Oracle 21 and Flink SQL CDC

### How to create the fat jar `delta-flink1.16-bundle-1.0`
You can build the fat jar by using command `maven clean package` in directory delta-flink-bundle. The used pom.xml is mostly similar to the example pom.xml as specified by [Delta](https://github.com/delta-io/connectors/blob/master/examples/delta-all-dep/pom.xml).

## Three different ways to implement CDC
### Flink CDC & Flink SQL
### Flink CDC & DataStream API
Add the application JAR using the Flink UI.
### Using Debezium & Kafka Connect

Follow the [instructions](https://github.com/debezium/debezium-examples/blob/main/tutorial/README.md#using-oracle) on how to use Debezium to monitor a Oracle database using Kafka Connect.

## Show the Demo environment
The demo environment consists of the following components.

### Minio (S3-compatible Storage)

* Web UI: [http://localhost:9000](http://localhost:9000) (user: `minio`, password: `minio123`)

### Flink JobManager and TaskManager

* Queries are executed on a FLink cluster
* Web UI: [http://localhost:8081](http://localhost:8081)