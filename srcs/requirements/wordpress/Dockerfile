FROM alpine:3.19

RUN apk update && apk upgrade && apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    curl


RUN adduser -u 82 -S -G www-data www-data
RUN id www-data
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www

COPY conf/www.conf /etc/php82/php-fpm.d/www.conf

CMD ["php-fpm82", "-F"]
