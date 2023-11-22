FROM alpine:3.17

# COPY .conf/ dest

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


# RUN wget https://wordpress.org/wordpress-6.3.2.tar.gz
# 	tar -xpf wordpress-6.3.2.tar.gz && \
# 	chown -R root:root wordpress && \
# 	mkdir -p var/www && \
# 	mv /wordpress /var/www/wordpress

# 	rm -rf wordpress-6.3.2.tar.gz && \

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar; \
	mv wp-cli.phar /usr/local/bin/wp; \
	wp cli update; \
	wp core download --path=/var/www

COPY conf/wp-config.php /var/www/.

COPY conf/wp-setup.sh /var/www/.

WORKDIR /var/www

RUN chmod +x wp-setup.sh

CMD ["sh", "wp-setup.sh"]
