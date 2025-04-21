FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y nginx openssl

RUN mkdir -p /etc/ssl/certs /etc/ssl/private && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx_selfsigned.key \
    -out /etc/ssl/certs/nginx_selfsigned.crt \
    -subj "/CN=jaimesan.42.fr"


COPY conf/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]