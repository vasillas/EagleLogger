#!/bin/bash
set -e

cd $PGINIT_DIR

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE USER $DB_NAME WITH PASSWORD '$DB_NAME';
  CREATE DATABASE $DB_NAME;
  GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_NAME;
  \c $DB_NAME
  CREATE EXTENSION pg_trgm;
  SET ROLE $DB_NAME;
  \i schema/zip_codes.sql
  \i schema/fcc.sql
  \i schema/callsigns.sql
  \i schema/users.sql
  \i schema/net_types.sql
  \i schema/nets.sql
  \i schema/checkins.sql
  \i schema/nets_view.sql
  \i schema/net_types_view.sql
  \copy zip_codes FROM 'csv/zip_codes.csv' WITH CSV
EOSQL

sh fccdata/import