#!/bin/bash

echo "Hello maria"
/etc/init.d/mariadb start

if [ -d "/var/lib/mysql/$DB_NAME" ]
then
	echo "Database exists"
else

mysql_secure_installation << EOF

Y
Y
$DB_ROOT
$DB_ROOT
Y
N
Y
Y
EOF

echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT'; FLUSH PRIVILEGES;" | mysql -uroot
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME; GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS'; FLUSH PRIVILEGES;" | mysql -uroot
# mysql -uroot -p$DB_ROOT $DB_NAME < /usr/local/bin/wordpress.sql

fi

# echo "TEST-005"
# sed -i "s|password =|password = $DB_ROOT|g" /etc/mysql/debian.cnf
/etc/init.d/mariadb stop
# kill $(cat /var/run/mysqld/mysqld.pid)
# echo "TEST-006"
exec "$@"