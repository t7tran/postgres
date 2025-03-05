FROM postgres:17.4-alpine

COPY ./rootfs /

# Install support for pgvector extension
RUN apk add --no-cache git build-base clang llvm19-dev && \
    cd /tmp && \
    git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make && \
    make install && \
    apk del git build-base clang llvm19-dev && \
    rm -rf /tmp/*

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]