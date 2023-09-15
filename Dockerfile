FROM postgres:14.8-alpine

COPY ./rootfs /

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]