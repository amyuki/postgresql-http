#!/bin/bash
#set -e
#psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
#    CREATE USER etl;
#    CREATE DATABASE etl;
#    GRANT ALL PRIVILEGES ON DATABASE etl TO etl;
#EOSQL