#!/bin/sh

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/g" /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASS/g" /var/www/html/wp-config.php
sed -i "s/localhost/$DB_HOST/g" /var/www/html/wp-config.php
sed -i "s/database_name_here/$DB_NAME/g" /var/www/html/wp-config.php

if [ ! -f "/var/www/html/wp-config.php" ]; then

	# Create Connection with Mariadb
	wp config create --dbhost=${DB_HOST} --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS}
	
	# Setup admin and user account
	wp core install --url=https://${DOMAIN_NAME} --title="inception" \
		--admin_user=${WP_AUSER} --admin_password=${WP_APASS} --admin_email=${WP_AEMAIL}
	wp user create ${WP_USER} ${WP_EMAIL} --user_pass=${WP_PASS}

fi

echo "==== Seem like fine ===="
exec /usr/sbin/php-fpm81 -F
