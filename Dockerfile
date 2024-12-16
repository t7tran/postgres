FROM postgres:15.10-alpine

COPY ./rootfs /

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]