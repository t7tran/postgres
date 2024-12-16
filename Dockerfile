FROM postgres:16.6-alpine

COPY ./rootfs /

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]