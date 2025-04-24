FROM alpine:3.20

# Install PHP and necessary PHP extensions, along with MariaDB client and other required utilities
RUN apk add --no-cache \
	php php-common php-fpm \
	php-mysqli php-json php-session php-zlib php-gd \
	php-mbstring php-openssl php-curl php-dom wget tar \
	mariadb-client curl \
	php-phar php-simplexml php-xmlwriter php-tokenizer php-zip

# Set the memory limit for PHP scripts to 256MB in the php.ini file (this is for my VM)
RUN echo 'memory_limit = 256M' >> /etc/php83/php.ini

# Download the WP-CLI and install it to /usr/local/bin/wp
RUN curl -L https://github.com/wp-cli/wp-cli/releases/download/v2.7.1/wp-cli-2.7.1.phar \
	-o /usr/local/bin/wp \
	&& chmod +x /usr/local/bin/wp  # Make the wp-cli file executable

# Copy the custom entrypoint script from the local directory to /usr/local/bin/ in the container
COPY ./tools/entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose port 9000 for PHP-FPM, used to process PHP requests
EXPOSE 9000

# Set the default command to run php-fpm in the foreground to keep the container alive and processing requests
CMD ["php-fpm83", "-F"]

# Set the entrypoint of the container to the custom entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]