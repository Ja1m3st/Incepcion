FROM alpine:3.20

RUN apk update && apk add --no-cache redis

RUN mkdir -p /data

EXPOSE 6379

RUN mkdir -p /etc/redis && mv /etc/redis.conf /etc/redis/ \
    && sed -i 's/# bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis/redis.conf

# COPY ./conf/redis.conf /etc/redis/redis.conf

CMD ["redis-server", "/etc/redis/redis.conf"]