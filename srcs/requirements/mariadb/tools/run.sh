
#!/bin/bash/

if [ ! -d "/var/lib/mysql/mysql" ]; then
	chown -R mysql:mysql /var/lib/mysql

	# init db
	mariadb_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
		return 1
	fi
fi

if [ ! -d "/var/lib/mysql/wordpress" ]; then
	cat << EOF > /tmp/create-db.sql
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';

CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
FLUSH PRIVILEGES;
EOF

	# as we dont have rc-service install in the container, so manully run it
	/usr/bin/mysqld --user=mysql --bootstrap < /tmp/create-db.sql
	rm -f /tmp/create-db.sql
fi