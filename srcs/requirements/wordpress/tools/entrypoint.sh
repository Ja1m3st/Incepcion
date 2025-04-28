#!/bin/sh

# Create directories wordpress and set permissions
mkdir -p /var/www/wordpress
chmod -R 755 /var/www/wordpress

# Wait for mariadb port 3306 to start
echo "Waiting for temporary MariaDB instance to be ready..." 2>/dev/stderr
while ! nc -z mariadb 3306; do
		sleep 1
done

# Inicialize WD if /var/www/wordpress/wp-config.php file not exits jet
if [ ! -f /var/www/wordpress/wp-config.php ]; then

	# Dowloading WordPress
	echo "Downloading WordPress core..."
	wp core download --allow-root --path='/var/www/wordpress'

	# Create WordPress file wp-config.php with .env variables
	echo "Creating wp-config.php..."
	wp config create --path='/var/www/wordpress' \
		--dbname=$WP_DATABASE \
		--dbuser=$WP_ADMIN_USER \
		--dbpass=$WP_ADMIN_PASSWORD \
		--dbhost='mariadb' --allow-root
	
	#Install Wordpress with some necesary features
	echo "Installing WordPress..."
	wp core install --allow-root --path='/var/www/wordpress' \
		--url=$WP_URL \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL --skip-email
	
	echo "Installing Redis Cache plugin..."
    wp plugin install redis-cache --activate --allow-root --path='/var/www/wordpress'

	wp plugin activate redis-cache --allow-root

    echo "Enabling Redis Object Cache..."
    wp redis enable --allow-root --path='/var/www/wordpress'

# Create a new user in WordPress with the editor role
cd /var/www/wordpress
wp user create $WP_USER $WP_EMAIL --role='editor' --user_pass=$WP_PASSWORD

else
  echo "WordPress already configured. Skipping installation."
fi

# Modify the PHP-FPM configuration to allow connections from any IP address (0.0.0.0 instead of 127.0.0.1)
sed -i "s/127.0.0.1/0.0.0.0/" /etc/php83/php-fpm.d/www.conf

# Executes the command passed to the container as an argument
exec "$@"