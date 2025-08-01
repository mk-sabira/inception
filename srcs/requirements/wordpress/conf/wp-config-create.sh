#!/bin/sh
set -e
if [ ! -f /var/www/wp-config.php ]; then
    wp config create \
        --dbname="${DB_NAME}" \
        --dbuser="${DB_USER}" \
        --dbpass="${DB_PASS}" \
        --dbhost="mariadb" \
        --path=/var/www \
        --allow-root \
        --skip-check
fi