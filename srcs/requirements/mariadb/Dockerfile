FROM alpine:3.20

# Install MariaDB and MariaDB client
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

# Create necessary directories for MariaDB data, socket, and logs, set the correct ownership and permissions
RUN mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql && \
    chmod 755 /var/lib/mysql /run/mysqld /var/log/mysql

# Copy the custom MariaDB configuration file into the container
COPY ./conf/my-config.cnf /etc/my.cnf.d/mariadb-server.cnf

# Copy the custom entrypoint script into the container
COPY ./tools/entrypoint.sh /usr/local/bin/

# Give execute permissions to the entrypoint script
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose port 3306 for MariaDB database access
EXPOSE 3306

# Set the entrypoint script to be executed when the container starts
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]