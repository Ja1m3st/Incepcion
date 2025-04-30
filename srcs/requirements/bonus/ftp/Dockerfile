FROM alpine:3.20

RUN apk update && apk add --no-cache vsftpd && apk add --no-cache shadow \
    && apk add --no-cache lftp

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 21 40000-40005

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]