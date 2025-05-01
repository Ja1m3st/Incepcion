FROM alpine:3.20


RUN apk add --no-cache php83 \
    php83-mysqli \
    php83-pdo \
    php83-pdo_mysql \
    php83-session \
    php83-curl \
    wget

WORKDIR /var/www

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php && \
    mv adminer-4.8.1.php index.php && \
    chown -R root:root /var/www/

EXPOSE 8080

CMD ["php83", "-S", "0.0.0.0:8080", "-t", "/var/www"]