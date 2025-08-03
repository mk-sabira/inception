#!/bin/bash

# Read credentials from secrets
WP_ADMIN_USER=$(head -n 1 /run/secrets/credentials)
WP_ADMIN_PASS=$(sed -n 2p /run/secrets/credentials)
WP_ADMIN_EMAIL=$(sed -n 3p /run/secrets/credentials)
DB_PASS=$(cat /run/secrets/db_password)

# Debug output (optional)
echo "DB_USER=${DB_USER}, DOMAIN_NAME=${DOMAIN_NAME}"

# Run wp-config-create.sh to generate wp-config.php if missing
sh /var/www/wp-config-create.sh

# Wait for MariaDB
until mariadb -h mariadb -u "${DB_USER}" -p"${DB_PASS}" -e "SELECT 1;" > /dev/null 2>&1; do
  echo "Waiting for MariaDB..."
  sleep 2
done

# Install WordPress if not installed
if ! wp core is-installed --path=/var/www/html; then
  wp core install \
    --path=/var/www/html \
    --url=https://${DOMAIN_NAME} \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASS}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --skip-email
fi

# Start PHP-FPM 8.2
exec php-fpm82 -F
