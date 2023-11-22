FROM alpine:3.17

# ARG MY_ENV_FILE

RUN apk update && apk upgrade

RUN apk add nginx openssl curl openrc

RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /etc/nginx/conf.d

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/incep.crt -keyout /etc/nginx/ssl/incep.key -subj "/C=TH/ST=Bangkok/L=Thonburi/O=42Bkk/OU=student/CN=pruangde/emailAddress=prinda.rua@gmail.com"
# RUN echo "<h1>Hello world!</h1>" > /var/www/localhost/htdocs/index.html;

COPY ./conf/my.conf /etc/nginx/http.d/my.conf


EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
# CMD [ "/bin/sh" ]

# /etc/nginx/snippets/fastcgi-php.conf
