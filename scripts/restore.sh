#!/bin/sh
if [ -z "$1" ]; then
  echo "Usage: restore BACKUP.tar.gz"
fi

if [ -e "$1" ]; then
  tar xzf $1 . -C $WP_DIR/wp-content
  chown -R www-data:www-data $WP_DIR
  echo "WordPress files $1 restored."
else
  echo "$1 not found."
fi
