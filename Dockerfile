FROM postgres:17.2-alpine

COPY ./rootfs /

# Install support for pgvector extension
RUN apk update && \
    apk add git build-base clang llvm19-dev && \
    cd /tmp && \
    git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make && \
    make install && \
    apk del git build-base clang llvm19-dev

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]