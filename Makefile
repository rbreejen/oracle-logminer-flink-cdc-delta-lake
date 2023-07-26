download-jars:
	cd jars
	curl -O -L https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-oracle-cdc/2.4.0/flink-sql-connector-oracle-cdc-2.4.0.jar
	curl -O -L https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-postgres-cdc/2.4.0/flink-sql-connector-postgres-cdc-2.4.0.jar
	curl -O -L https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc8/23.2.0.0/ojdbc8-23.2.0.0.jar
	curl -O -L https://repo1.maven.org/maven2/org/apache/hudi/hudi-flink1.16-bundle/0.13.1/hudi-flink1.16-bundle-0.13.1.jar
	curl -O -L https://repo1.maven.org/maven2/org/apache/flink/flink-s3-fs-hadoop/1.16.1/flink-s3-fs-hadoop-1.16.1.jar
	

download-delta-and-compile:
	REPOSRC=git@github.com:delta-io/connectors.git
	LOCALREPO=~/connectors
	git clone "$REPOSRC" "$LOCALREPO" 2> /dev/null || git -C "$LOCALREPO" pull
	sbt flink/publishM2
	sbt standaloneCosmetic/publishM2
	
compile-flink-delta-connector:
	mvn clean package -f ./delta-connector/pom.xml	
	cp delta-connector/target/flink-delta-connector-1.0.jar ./jars
	