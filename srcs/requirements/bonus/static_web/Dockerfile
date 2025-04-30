FROM alpine:3.20

RUN apk update && apk add --no-cache apache2

# Cambia el puerto 80 a 81 en httpd.conf
RUN sed -i 's/Listen 80/Listen 81/' /etc/apache2/httpd.conf

COPY ./docs/ /var/www/localhost/htdocs


EXPOSE 81

# Ejecuta Apache en primer plano
CMD ["httpd", "-D", "FOREGROUND"]