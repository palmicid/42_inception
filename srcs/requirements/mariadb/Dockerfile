# FROM alpine:3.17

# RUN apk add mariadb mariadb-server-utils



FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get -y install mariadb-server mariadb-client

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

COPY tools/init.sh /usr/local/bin/.

RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld

RUN chmod +x /usr/local/bin/init.sh

EXPOSE 3306

# # CMD [ "/bin/bash"]

ENTRYPOINT [ "/usr/local/bin/init.sh" ]

# USER mysql

# CMD ["mysqld", "--bind-address=0.0.0.0", "-uroot"]

CMD [ "tail", "-f", "/dev/null" ]
