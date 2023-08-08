# docker-postgres
Extension of the official PostgreSQL with support for script execution on every startup

	docker pull ghcr.io/t7tran/postgres:13.11

All scripts mounted under `/docker-entrypoint-initdb.d/` are always executed on every startup.