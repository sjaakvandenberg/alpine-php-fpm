FROM alpine:edge

RUN set +x \
&& addgroup -g 82 -S www-data \
&& adduser -u 82 -D -S -G www-data www-data \
&& apk --update add --no-cache \
--repository "http://dl-4.alpinelinux.org/alpine/edge/testing" \
curl \
libjpeg-turbo \
libjpeg-turbo-utils \
ncurses \
php7 \
php7-dom \
php7-ctype \
php7-curl \
php7-fpm \
php7-gd \
php7-intl \
php7-json \
php7-mbstring \
php7-mysqlnd \
php7-opcache \
php7-pdo \
php7-pdo_mysql \
php7-phar \
php7-posix \
php7-session \
php7-xml \
php7-zlib \
pngquant \
&& rm -rf /var/cache/apk \
&& ln -s /usr/bin/php7 /usr/bin/php \
&& sed -i "s/;date.timezone =/date.timezone = Europe\/Amsterdam/" /etc/php7/php.ini \
&& curl -sL https://goo.gl/FJNWum -o /usr/bin/wp-cli \
&& chmod +x /usr/bin/wp-cli

COPY php-fpm.conf  /etc/php7/php-fpm.conf
COPY php-fpm.d/*   /etc/php7/php-fpm.d/
COPY scripts/*     /usr/local/bin/
COPY init.sh       /init.sh
COPY app/          /app

ADD https://wordpress.org/latest.tar.gz /app

EXPOSE 9000

CMD ["/bin/sh", "/init.sh"]
