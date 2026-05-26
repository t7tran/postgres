FROM postgres:18.4-alpine

COPY ./rootfs /

# Install support for pgvector extension
RUN apk add --no-cache git build-base clang19 llvm19-dev && \
    cd /tmp && \
    git clone --branch v0.8.2 https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make && \
    make install && \
    apk del git build-base clang19 llvm19-dev && \
    rm -rf /tmp/*

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]