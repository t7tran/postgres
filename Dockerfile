FROM postgres:15.7-alpine

COPY ./rootfs /

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]