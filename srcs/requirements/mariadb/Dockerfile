# FROM alpine:3.17

# RUN apk add mariadb mariadb-server-utils



FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get -y install mariadb-server
# mariadb-client

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

COPY tools/init.sh .

EXPOSE 3306

# # CMD ["/usr/bin/mysqld", "-uroot", "--skip-log-error"]
CMD [ "tail", "-f", "/dev/null" ]
# # CMD [ "/bin/bash"]
