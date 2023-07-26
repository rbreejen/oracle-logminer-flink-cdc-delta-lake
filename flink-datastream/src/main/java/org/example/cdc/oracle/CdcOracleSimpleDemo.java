package org.example.cdc.oracle;

import com.ververica.cdc.connectors.oracle.OracleSource;
import com.ververica.cdc.debezium.DebeziumSourceFunction;
import com.ververica.cdc.debezium.JsonDebeziumDeserializationSchema;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

import java.util.Properties;

/**
 * org.example.cdc.oracle.CdcOracleSimpleDemo
 */
public class CdcOracleSimpleDemo {

    public static void main(String[] args) throws Exception {

        Properties dbzProperties = new Properties();
//        debeziumProps.setProperty("log.mining.strategy", "online_catalog");
//        debeziumProps.setProperty("log.mining.continuous.mine", String.valueOf(true));
//        debeziumProps.setProperty("database.connection.adapter", "xstream");
        dbzProperties.setProperty("database.tablename.case.insensitive", String.valueOf(false));
        dbzProperties.setProperty("database.pdb.name","XEPDB1");


//        https://github.com/ververica/flink-cdc-connectors/wiki/FAQ#q1-oracle-cdcs-archive-logs-grow-rapidly-and-read-logs-slowly
//        props.setProperty("debezium.log.mining.strategy","online_catalog");
//        props.setProperty("debezium.log.mining.continuous.mine","true");

        DebeziumSourceFunction<String> sourceFunction =
                OracleSource.<String>builder()
                        .hostname("oracle")
                        .port(1521)
                        .database("XE")
                        .schemaList("DEBEZIUM") // monitor debezium & c##myuser schema's
                        .tableList("DEBEZIUM.SAMPLE_DATA") // monitor sample_data
                        .username("C##MYUSER")
                        .password("mypassword")
                        .debeziumProperties(dbzProperties)
//            .startupOptions(StartupOptions.latest())
                        .deserializer(new JsonDebeziumDeserializationSchema())
                        .build();

        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.addSource(sourceFunction)
                .print()
                .setParallelism(1);

        env.execute();
    }
}