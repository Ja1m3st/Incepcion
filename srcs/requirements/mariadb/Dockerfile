FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY ./tools/init.sql /etc/mysql/init.sql
COPY script.sh .

RUN mkdir /run/mysqld

CMD ["mysqld"]