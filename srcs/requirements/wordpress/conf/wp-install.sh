#!/bin/sh
# Wait for MariaDB with mysqladmin and timeout
set -e
for i in {1..30}; do
    if mysqladmin -h mariadb -u "${DB_USER}" -p"${DB_PASS}" ping --silent; then
        break
    fi
    echo "Waiting for MariaDB..."
    sleep 2
done

if ! mysqladmin -h mariadb -u "${DB_USER}" -p"${DB_PASS}" ping --silent; then
    echo "Error: MariaDB not available after 60 seconds"
    exit 1
fi

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

exec /usr/sbin/php-fpm82 -F