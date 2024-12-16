DO
$do$
BEGIN
    IF NOT EXISTS (
        SELECT FROM pg_catalog.pg_roles  -- SELECT list can be empty for this
        WHERE  rolname = 'sample') THEN

        CREATE ROLE sample LOGIN PASSWORD 'sample';
    END IF;
END
$do$;

REVOKE CONNECT ON DATABASE sample FROM PUBLIC;

GRANT CONNECT
ON DATABASE sample 
TO sample;

\c sample
create extension if not exists "pgcrypto";
