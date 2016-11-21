#!/bin/sh
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="/backup"

tar czf $BACKUP_DIR/$MYSQL_DATABASE-$TIMESTAMP.tar.gz . -C $WP_DIR/wp-content

echo "WP files backed up as $BACKUP_DIR/$MYSQL_DATABASE-$TIMESTAMP.tar.gz"
