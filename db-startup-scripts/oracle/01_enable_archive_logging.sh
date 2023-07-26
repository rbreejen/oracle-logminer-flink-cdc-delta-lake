#!/bin/sh

echo 'Enabling archive log mode'

ORACLE_SID=XE
export ORACLE_SID
sqlplus /nolog <<- EOF
	CONNECT sys/Admin123 AS SYSDBA
	alter system set db_recovery_file_dest_size = 5G;
	alter system set db_recovery_file_dest = '/opt/oracle/oradata' scope=spfile;
	shutdown immediate
	startup mount
	alter database archivelog;
	alter database open;
    -- Should show "Database log mode: Archive Mode"
	archive log list
	exit;
EOF
