CREATE or REPLACE FUNCTION etl_from_couchdb.load_couchdb(IN seq character varying, IN db character varying, IN url character varying)
    RETURNS boolean
AS $BODY$
begin
	insert into etl_from_couchdb.changes(
		status,
		content_type,
		headers,
		content,
		request_seq,
		pending,
		results,
		last_seq
	)
	select
		status,
		content_type,
		headers,
		content::jsonb,
		seq as request_seq,
		(content::jsonb->>'pending')::int ,
		content::jsonb->'results',
	  	content::jsonb->'last_seq'
	from
		http_get(url || '/' || db || '/_changes?include_docs=true&limit=500&since=' || seq);
	return true;
end;
$BODY$  LANGUAGE plpgsql;
ALTER FUNCTION etl_from_couchdb.load_couchdb(character varying, character varying, character varying) OWNER TO postgres;