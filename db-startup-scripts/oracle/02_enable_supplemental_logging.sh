#!/bin/sh

echo 'Enabling supplemental logging'

sqlplus sys/Admin123@//localhost:1521/XE as sysdba <<- EOF
  -- Enable supplemental logging for database
  ALTER DATABASE ADD SUPPLEMENTAL LOG DATA;
  -- Enable supplemental logging for all tables:
  ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;
  exit;
EOF