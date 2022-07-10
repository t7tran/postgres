FROM postgres:13.7-alpine

RUN echo -e '\n\
      if [[ -n `ls -1 /docker-entrypoint-initdb.d/*.{sh,sql} 2>/dev/null` ]]; then\n\
        docker_verify_minimum_env\n\
        ls /docker-entrypoint-initdb.d/ > /dev/null\n\
        export PGPASSWORD="${PGPASSWORD:-$POSTGRES_PASSWORD}"\n\
        docker_temp_server_start "$@"\n\
        docker_process_init_files /docker-entrypoint-initdb.d/*\n\
        docker_temp_server_stop\n\
        unset PGPASSWORD\n\
        echo\n\
        echo "PostgreSQL init process complete; ready for start up."\n\
      fi\n\
    ' > /tmp/else.txt && \
    sed -i '/Skipping initialization/r /tmp/else.txt' /usr/local/bin/docker-entrypoint.sh && \
    sed -i '/Skipping initialization/d' /usr/local/bin/docker-entrypoint.sh && \
    echo -e '\n\
        setup_db_if_not_exists() {\n\
            local dbAlreadyExists\n\
            dbAlreadyExists="$(\n\
docker_process_sql --dbname postgres --set db="${1?}" --tuples-only <<-'"'"'EOSQL'"'"'\n\
SELECT 1 FROM pg_database WHERE datname = :'"'"'db'"'"' ;\n\
EOSQL\n\
            )"\n\
            if [ -z "$dbAlreadyExists" ]; then\n\
docker_process_sql --dbname postgres --set db="${1?}" <<-'"'"'EOSQL'"'"'\n\
CREATE DATABASE :"db" ;\n\
EOSQL\n\
                echo\n\
            fi\n\
        }\n\
    ' > /tmp/else.txt && \
    sed -i '/# create initial database/r /tmp/else.txt' /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]