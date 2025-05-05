FROM alpine:3.20

RUN apk update && apk add --no-cache redis

EXPOSE 6379

RUN mkdir -p /etc/redis && mv /etc/redis.conf /etc/redis/ \
    && echo 'maxmemory 256mb' >> /etc/redis/redis.conf \ 
    && echo 'maxmemory-policy allkeys-lru' >> /etc/redis/redis.conf \
    && sed -i 's/# bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis/redis.conf

RUN echo 'vm.overcommit_memory = 1' >> /etc/sysctl.conf

EXPOSE 6379

CMD ["redis-server", "--protected-mode", "no"]