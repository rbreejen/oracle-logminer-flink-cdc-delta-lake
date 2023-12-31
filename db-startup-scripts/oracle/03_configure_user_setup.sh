#!/bin/sh

echo 'Creating user and required priviliges for LogMiner'

sqlplus sys/Admin123@//localhost:1521/XE as sysdba <<- EOF
  CREATE ROLE C##CDC_PRIVS;
  CREATE USER C##MYUSER IDENTIFIED BY mypassword CONTAINER=ALL;
  ALTER USER C##MYUSER QUOTA UNLIMITED ON USERS;
  ALTER USER C##MYUSER SET CONTAINER_DATA = ALL CONTAINER=CURRENT;
  GRANT C##CDC_PRIVS to C##MYUSER CONTAINER=ALL;

  GRANT CREATE SESSION TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT EXECUTE ON SYS.DBMS_LOGMNR TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT LOGMINING TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON V_\$LOGMNR_CONTENTS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON V_\$DATABASE TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON V_\$THREAD TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON V_\$PARAMETER TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON V_\$NLS_PARAMETERS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON V_\$TIMEZONE_NAMES TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON ALL_INDEXES TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON ALL_OBJECTS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON ALL_USERS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON ALL_CATALOG TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON ALL_CONSTRAINTS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON ALL_CONS_COLUMNS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON ALL_TAB_COLS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON ALL_IND_COLUMNS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON ALL_ENCRYPTED_COLUMNS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON ALL_LOG_GROUPS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON ALL_TAB_PARTITIONS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON SYS.DBA_REGISTRY TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON SYS.OBJ$ TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON DBA_TABLESPACES TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON DBA_OBJECTS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON SYS.ENC$ TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT CONNECT TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON DBA_PDBS TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON CDB_TABLES TO C##CDC_PRIVS CONTAINER=ALL;

  GRANT CREATE TABLE TO C##MYUSER container=all;
  GRANT CREATE SEQUENCE TO C##MYUSER container=all;
  GRANT CREATE TRIGGER TO C##MYUSER container=all;
  GRANT FLASHBACK ANY TABLE TO C##MYUSER container=all;

  -- The following privileges are required additionally for 19c compared to 12c.
  GRANT SELECT ON V_\$ARCHIVED_LOG TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON V_\$LOG TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON V_\$LOGFILE TO C##CDC_PRIVS CONTAINER=ALL;
  GRANT SELECT ON V_\$INSTANCE to C##CDC_PRIVS CONTAINER=ALL;
  GRANT EXECUTE ON SYS.DBMS_LOGMNR TO C##CDC_PRIVS;
  GRANT EXECUTE ON SYS.DBMS_LOGMNR_D TO C##CDC_PRIVS;
  GRANT EXECUTE ON SYS.DBMS_LOGMNR_LOGREP_DICT TO C##CDC_PRIVS;

  -- Check Database Instance Version
  GRANT SELECT ON V_\$INSTANCE to C##CDC_PRIVS;

  -- extra
  GRANT SELECT_CATALOG_ROLE TO C##MYUSER CONTAINER=ALL;
  GRANT EXECUTE_CATALOG_ROLE TO C##MYUSER CONTAINER=ALL; 

  exit;
EOF

sqlplus sys/Admin123@//localhost:1521/XEPDB1 as sysdba <<- EOF
  CREATE USER debezium IDENTIFIED BY dbz;
  GRANT CONNECT TO debezium;
  GRANT CREATE SESSION TO debezium;
  GRANT CREATE TABLE TO debezium;
  GRANT CREATE SEQUENCE to debezium;
  ALTER USER debezium QUOTA 100M on users;

  -- extra for test data creation
  GRANT CREATE PROCEDURE TO debezium;
  GRANT CREATE TRIGGER TO debezium;
  GRANT CREATE JOB TO debezium;

  exit;
EOF