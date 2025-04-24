FROM alpine:3.20

# Update the package list, upgrade existing packages, and install Nginx and OpenSSL
RUN apk update && apk upgrade && apk add --no-cache nginx openssl

# Create directories for SSL certificates and private keys, and generate a self-signed SSL certificate for Nginx
RUN mkdir -p /etc/ssl/certs /etc/ssl/private && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=ES/ST=Madrid/L=Madrid/O=42 School/OU=jaimesan/CN=jaimesan.42.fr"

# Copy the custom Nginx configuration file to the appropriate location inside the container
COPY conf/default.cnf /etc/nginx/http.d/default.conf

# Set the default command to run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]