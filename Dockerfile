FROM postgres:14.9-alpine

COPY ./rootfs /

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]