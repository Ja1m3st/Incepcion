FROM alpine:3.20

# Instalar dependencias necesarias
RUN apk update && apk add --no-cache \
    apache2 \
    php83 \
    php83-apache2 \
    php83-curl \
    php83-cli \
    php83-mysqli \
    php83-gd \
    mariadb \
    wget \
    && rm -rf /var/cache/apk/*

# Descargar Adminer
WORKDIR /var/www/localhost/htdocs 
RUN wget https://www.adminer.org/latest.php -O /var/www/localhost/htdocs/adminer.php && \
    chown -R apache:apache /var/www/localhost/htdocs/adminer.php && \
    chmod 755 /var/www/localhost/htdocs/adminer.php && \
    rm -rf /var/www/localhost/htdocs/index.html

# Configurar Apache para escuchar en el puerto 8080
RUN sed -i "s/Listen 80/Listen 8080/g" /etc/apache2/httpd.conf

# Exponer el puerto 8080
EXPOSE 8080

# Comando para ejecutar Apache en primer plano
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]