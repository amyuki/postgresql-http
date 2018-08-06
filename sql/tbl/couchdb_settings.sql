-- Table: etl_from_couchdb.couchdb_settings

-- DROP TABLE etl_from_couchdb.couchdb_settings;

CREATE TABLE etl_from_couchdb.couchdb_settings
(
    id integer NOT NULL DEFAULT nextval('etl_from_couchdb.couchdb_settings_id_seq'::regclass),
    key character varying(256) COLLATE pg_catalog."default" NOT NULL,
    value character varying(2083) COLLATE pg_catalog."default" NOT NULL,
    comments text COLLATE pg_catalog."default",
    CONSTRAINT couchdb_settings_pkey PRIMARY KEY (id),
    CONSTRAINT u_kv UNIQUE (key, value)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE etl_from_couchdb.couchdb_settings
    OWNER to postgres;