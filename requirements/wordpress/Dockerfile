FROM alpine:3.19

# Instalar PHP, php-fpm y extensiones necesarias para WordPress
RUN apk update && apk add --no-cache \
    php php-fpm php-mysqli php-curl php-json php-session \
    php-phar php-openssl php-zlib php-gd php-iconv php-mbstring \
    php-dom php-exif php-ctype php-tokenizer

# Descargar WordPress
RUN apk add --no-cache php-fpm
RUN apk update && apk add --no-cache curl
RUN curl -O https://wordpress.org/wordpress-6.8.tar.gz && \
    tar -xvzf wordpress-6.8.tar.gz && \
    mv wordpress /var/www/ && \
    rm wordpress-6.8.tar.gz

# Copiar configuración personalizada
COPY config/wp-config.php /var/www/wordpress/wp-config.php

# Crear usuario www-data
RUN adduser -D -g 'www' www

# Dar permisos a www-data
RUN chown -R www:www /var/www/wordpress

# Exponer puerto de php-fpm (por defecto 9000)
EXPOSE 9000

# Ejecutar php-fpm en primer plano correctamente como PID 1
CMD ["php-fpm82", "-F"]
