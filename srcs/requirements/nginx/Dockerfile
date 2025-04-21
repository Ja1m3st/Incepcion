FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y nginx openssl

RUN mkdir -p /etc/ssl/certs /etc/ssl/private && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/jaimesan.42.fr.key \
    -out /etc/ssl/certs/jaimesan.42.fr.crt \
    -subj "/CN=jaimesan.42.fr"


COPY conf/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]