FROM alpine:3.17

RUN apk update && apk upgrade

RUN apk add php81 \
	php81-fpm \
	php81-mysqli \
	php81-json \
	php81-curl \
	php81-dom \
	php81-exif \
	php81-fileinfo \
	php81-mbstring \
	php81-openssl \
	php81-xml \
	php81-phar \
	wget

RUN mkdir -p /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar; \
	mv wp-cli.phar /usr/local/bin/wp; \
	wp cli update; \
	wp core download --path=/var/www/html

COPY conf/www.conf /etc/php81/php-fpm.d/.

COPY conf/wp-config.php /var/www/html.

COPY conf/wp-setup.sh /var/www/html

WORKDIR /var/www/html

RUN chmod +x wp-setup.sh

CMD ["sh", "wp-setup.sh"]
