#!/bin/sh

# Create directories mariadb
mkdir -p /var/lib/mysql /run/mysqld
if [ ! -d /var/lib/mysql ] || [ ! -d /run/mysqld ]; then
	echo "Directories were not correctly created" 2>/dev/stderr
	exit 1
fi

# Set permissions folers
chown -R mysql:mysql /var/lib/mysql /run/mysqld
chmod -R 755 /run/mysqld
cd /var/lib/mysql

# Inicialize BBDD if /var/lib/mysql/mysql folder not exits jet
if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initializing database..." 2>/dev/stderr
	mariadb-install-db --user=mysql --skip-test-db --datadir=/var/lib/mysql

	# Start a temporary instance of MariaDB with networking disabled
	echo "Starting temporary MariaDB instance for initialization..." 2>/dev/stderr
	mariadbd-safe --skip-networking --socket=/var/run/mysqld/mysqld.sock --datadir=/var/lib/mysql &
	TEMP_PID=$!

	# Wait for the server to become available
	echo "Waiting for temporary MariaDB instance to be ready..." 2>/dev/stderr
	while ! mariadb-admin ping --socket=/var/run/mysqld/mysqld.sock --silent; do
		sleep 1
	done

	# Execute SQL commands
	echo "Executing initial SQL commands..." 2>/dev/stderr
	mariadb -u root --socket=/var/run/mysqld/mysqld.sock <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

	# Shut down the temporary MariaDB instance
    echo "Shutting down temporary MariaDB instance..." 2>/dev/stderr
    mariadb-admin --socket=/var/run/mysqld/mysqld.sock shutdown
    wait $TEMP_PID
fi

cd /usr/
echo "Wordpress table was successfully created, database setup COMPLETE" 2>/dev/stderr

# Launch MariaDB in normal mode, accessible from the network (thanks to 0.0.0.0),
# and start mariadb in the foreground to keep it running 
mariadbd-safe --user=mysql --bind-address="0.0.0.0" --verbose --datadir=/var/lib/mysql