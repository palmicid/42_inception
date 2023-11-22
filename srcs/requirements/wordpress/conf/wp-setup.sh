#!/bin/sh



if [ ! -f "/var/www/wp-config.php" ]; then

	# Create Connection with Mariadb
	wp config create --dbhost=${DB_HOST} --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS}
	
	# Setup admin and user account
	wp core install --url=https://${DOMAIN_NAME} --title="inception" \
		--admin_user=${WP_AUSER} --admin_password=${WP_APASS} --admin_email=${WP_AEMAIL}
	wp user create ${WP_USER} ${WP_EMAIL} --user_pass=${WP_PASS}

fi

echo "==== Seem like fine ===="
exec /usr/sbin/php-fpm81 -F
