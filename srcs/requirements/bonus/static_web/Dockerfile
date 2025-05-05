FROM alpine:3.20

RUN apk update && apk add --no-cache apache2

RUN sed -i 's/Listen 80/Listen 81/' /etc/apache2/httpd.conf

COPY ./docs/ /var/www/localhost/htdocs

EXPOSE 81

CMD ["httpd", "-D", "FOREGROUND"]