FROM alpine:3.20

RUN apk add --no-cache curl tar

RUN curl -L https://github.com/traefik/whoami/releases/download/v1.11.0/whoami_v1.11.0_linux_amd64.tar.gz \
    -o /tmp/whoami.tar.gz \
    && tar -xzf /tmp/whoami.tar.gz -C /usr/local/bin/ \
    && rm /tmp/whoami.tar.gz

RUN ls -la /usr/local/bin/whoami \
    && chmod +x /usr/local/bin/whoami

EXPOSE 80

CMD ["/usr/local/bin/whoami"]