# docker-postgres
Extension of the official PostgreSQL with support for script execution on every startup

	docker pull ghcr.io/t7tran/postgres:14.9.0

All scripts mounted under `/docker-entrypoint-initdb.d/` are always executed on every startup.