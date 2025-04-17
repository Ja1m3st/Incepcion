FROM alpine:3.19

# Instalar MariaDB y utilidades
RUN apk update && apk add --no-cache mariadb mariadb-client

# Crear directorio para la base de datos
RUN mkdir -p /var/lib/mysql

# Copiar configuración opcional (si la quieres personalizada)
 COPY conf/custom.cnf /etc/my.cnf.d/

# Crear usuario mysql
RUN adduser -D -g 'mysql' mysql

# Dar permisos a mysql
RUN chown -R mysql:mysql /var/lib/mysql

# Exponer puerto de MariaDB (3306)
EXPOSE 3306

# Copiar script de inicialización
COPY ./tools/ /docker-entrypoint-initdb.d/

# Comando para iniciar MariaDB correctamente como PID 1
CMD ["mysqld"]

