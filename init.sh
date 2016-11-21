#!/bin/sh

# Rename scripts
for script in /usr/local/bin/*.sh; do
  mv -f "$script" "${script%.sh}";
done

printf 'ENVIRONMENT VARIABLES\n'
printf '---------------------\n'
env

# Wait for database to come online
# printf "Waiting on $MYSQL_DATABASE\n"
# while [ "$(dbtest)" != "1" ]; do
#   printf "No database detected...\n"
#   sleep 5
# done
# printf "Database found!\n"

# Add latest version of WordPress
wp core download --color --locale=en_US

# Generate wp-config.php
# wp core config \
# --locale=en_US \
# --skip-check \
# --dbhost=$MYSQL_HOST \
# --dbname=$MYSQL_DATABASE \
# --dbuser=$MYSQL_USER \
# --dbpass=$MYSQL_PASSWORD \
# --dbprefix=wp_ \
# --extra-php <<PHP
# define( 'WP_REDIS_HOST', 'redis' );
# PHP

# Install WordPress
# wp core install \
# --url=$WP_URL \
# --admin_user=$WP_USER \
# --admin_password=$WP_PASSWORD \
# --admin_email=$WP_EMAIL \
# --skip-email \
# --title=$WP_TITLE

# Plugins
# wp plugin delete akismet hello

# wp plugin install \
# caldera-forms \
# check-email \
# cookie-notice \
# duplicate-page \
# easy-image-sizes \
# easy-watermark \
# facebook-auto-publish \
# nginx-helper \
# redis-cache \
# remove-query-strings-from-static-resources \
# resize-image-after-upload \
# rvg-optimize-database \
# smtp-mailer \
# tiny-compress-images \
# woocommerce \
# wordfence \
# wordpress-importer \
# wordpress-seo \
# wp-google-authenticator \
# wp-photonav \
# wp-to-twitter \
# --activate

# Themes
# wp theme install /tmp/enfold.zip
# cp -r /tmp/enfold-child/. $WP_DIR/wp-content/themes/enfold-child
# wp theme activate enfold-child
# wp theme delete twentyfourteen twentyfifteen twentysixteen

# Copy uploads directory
# cp -r /tmp/uploads/ $WP_DIR/wp-content/
# rm -r /tmp/sess*

# chown -R www-data:www-data /var/www

uname -a
php --version
wp cli version

# echo
# echo "PHP-FPM       : $(getent hosts php-fpm | awk '{print $1}')"
# echo "Adminer       : $(getent hosts adminer | awk '{print $1}')"
# echo "MariaDB       : $(getent hosts mysql | awk '{print $1}')"
# echo "Nginx         : $(getent hosts nginx | awk '{print $1}')"
# echo "Redis         : $(getent hosts redis | awk '{print $1}')"
# echo
echo "WordPress     : $(wp core version)"
echo "URL           : $WP_URL"
echo "Directory     : $WP_DIR"
echo
echo "User          : $WP_USER"
echo "Password      : $WP_PASSWORD"
echo "Email         : $WP_EMAIL"
echo "Database      : $MYSQL_DATABASE"
echo
echo "Tools"
echo "----------------------------------------"
echo "backups       List backups in /backup/"
echo "backup        Make backup of wp-content"
echo "restore FILE  Restore backup"
echo "img           Optimize images"
echo "resize        Resize individual image"
echo "wp ARGS       WP-CLI"
echo

php-fpm7 --nodaemonize
