-- Table: etl_from_couchdb.changes

-- DROP TABLE etl_from_couchdb.changes;

CREATE or REPLACE TABLE etl_from_couchdb.changes
(
    id integer NOT NULL DEFAULT nextval('etl_from_couchdb.changes_id_seq'::regclass),
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

ALTER TABLE etl_from_couchdb.changes
    OWNER to postgres;