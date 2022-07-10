# docker-postgres
Extension of the official PostgreSQL with support for script execution on every startup

	docker pull t7tran/postgres:13.7

All scripts mounted under `/docker-entrypoint-initdb.d/` are always executed on every startup.