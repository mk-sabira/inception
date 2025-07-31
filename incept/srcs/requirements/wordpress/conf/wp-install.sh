#!/bin/sh
# Wait for MariaDB to be ready
until mysqladmin ping -h mariadb --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Install WordPress if not already installed
if ! wp core is-installed --path=/var/www --allow-root; then
    wp core install \
        --url=https://${DOMAIN_NAME} \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASS}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --path=/var/www \
        --allow-root
fi