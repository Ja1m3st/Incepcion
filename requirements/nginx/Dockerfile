FROM alpine:3.19

# Instalar nginx y openssl
RUN apk update && apk add --no-cache nginx openssl

# Crear directorios necesarios
RUN mkdir -p /run/nginx

# Copiar la configuración y los certificados SSL
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/ssl/ /etc/ssl/

# Crear usuario www-data
RUN adduser -D -g 'www' www

# Exponer el puerto 443
EXPOSE 443

# Comando para lanzar nginx en primer plano (correcto como PID 1)
CMD ["nginx", "-g", "daemon off;"]