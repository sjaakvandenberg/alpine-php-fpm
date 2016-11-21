#!/bin/sh

if [ "$1" == "-h" ] \
|| [ "$1" == "help" ] \
|| [ "$1" == "--help" ] \
|| [ "$1" == "" ]; then
  echo
  echo "WP-CLI Usage"
  echo
  echo "====================================="
  echo
  echo "wp core         wp plugin    wp db"
  echo "-------         ---------    -----"
  echo "check-update    list         cli"
  echo "update-db       install      tables"
  echo "update          activate     export"
  echo "version         delete       import"
  echo "                toggle       optimize"
  echo "wp post         uninstall    repair"
  echo "-------         update"
  echo "create          search"
  echo "delete"
  echo "edit"
  echo "list"
  echo
  exit
fi

wp-cli --allow-root --color --path=$WP_DIR $@
