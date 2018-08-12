#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER etl;
    CREATE DATABASE etl
        WITH 
        OWNER = postgres
        ENCODING = 'UTF8'
        LC_COLLATE = 'zh_CN.UTF-8'
        LC_CTYPE = 'zh_CN.UTF-8'
        TABLESPACE = pg_default
        CONNECTION LIMIT = -1;    
    GRANT ALL PRIVILEGES ON DATABASE etl TO etl;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname etl <<-EOSQL
    CREATE SCHEMA IF NOT EXISTS etl_from_couchdb;
    create extension IF NOT EXISTS file_fdw;
    create extension IF NOT EXISTS postgres_fdw;
    create extension IF NOT EXISTS "uuid-ossp";
    create extension IF NOT EXISTS http;
EOSQL


psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname etl <<-EOSQL
    DROP TABLE if exists etl_from_couchdb.changes;
    CREATE TABLE IF NOT EXISTS etl_from_couchdb.changes
    (
        id SERIAL NOT NULL,
        request_seq character varying(2048) COLLATE pg_catalog."default" NOT NULL,
        content jsonb,
        error text COLLATE pg_catalog."default",
        status integer,
        insert_time timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
        content_type character varying COLLATE pg_catalog."default",
        headers character varying COLLATE pg_catalog."default",
        pending integer,
        last_seq character varying COLLATE pg_catalog."default",
        results jsonb,
        array_f jsonb[],
        CONSTRAINT changes_pkey PRIMARY KEY (id),
        CONSTRAINT u_seq UNIQUE (request_seq)
    )
    WITH (
        OIDS = FALSE
    )
    TABLESPACE pg_default;
    ALTER TABLE etl_from_couchdb.changes OWNER to postgres;
EOSQL