-- Table: etl_from_couchdb.couchdb_settings
DROP TABLE if exists etl_from_couchdb.couchdb_settings;

CREATE TABLE etl_from_couchdb.couchdb_settings
(
    id SERIAL NOT NULL ,
    key character varying(256) COLLATE pg_catalog."default" NOT NULL,
    value character varying(2083) COLLATE pg_catalog."default" NOT NULL,
    comments text COLLATE pg_catalog."default",
    CONSTRAINT couchdb_settings_pkey PRIMARY KEY (id),
    CONSTRAINT u_kv UNIQUE (key)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE etl_from_couchdb.couchdb_settings OWNER to postgres;