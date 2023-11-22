FROM alpine:3.17

RUN apk update && apk upgrade

RUN apk add mariadb mariadb-client mariadb-server-utils openrc

RUN mkdir -p /var/run/mysqld; \
	chmod 777 /var/run/mysqld

COPY conf/* /etc/my.cnf.d/

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY tools/run.sh .

RUN sh run.sh && rm run.sh

# USER mysql

EXPOSE 3306

CMD ["/usr/bin/mysqld", "-P 3306", "--skip-log-error"]
# CMD [ "tail", "-f", "/dev/null" ]
