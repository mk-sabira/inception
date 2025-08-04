FROM alpine:3.21

ARG PHP_VERSION=8.2 \
    DB_NAME \
    DB_USER \
    DB_PASS \
    WP_ADMIN_USER \
    WP_ADMIN_EMAIL \
    WP_TITLE \
    WP_TABLE_PREFIX

# Install PHP 8.2 and dependencies
RUN apk update && apk upgrade && apk add --no-cache \
    php82 \
    php82-cli \
    php82-fpm \
    php82-mysqli \
    php82-json \
    php82-curl \
    php82-dom \
    php82-exif \
    php82-fileinfo \
    php82-mbstring \
    php82-openssl \
    php82-xml \
    php82-zip \
    php82-redis \
    php82-phar \
    wget \
    unzip \
    curl \
    mariadb-client && \
    ln -s /usr/bin/php82 /usr/bin/php && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php82/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www

# Install WordPress
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip && \
    chown -R nobody:nogroup /var/www

# Copy configuration and setup scripts
COPY requirements/wordpress/conf/wp-config-create.sh /usr/local/bin/wp-config-create.sh
COPY requirements/wordpress/conf/wp-install.sh /usr/local/bin/wp-install.sh

# Verify scripts exist and set permissions
RUN ls -l /usr/local/bin/wp-config-create.sh /usr/local/bin/wp-install.sh && \
    chmod +x /usr/local/bin/wp-config-create.sh /usr/local/bin/wp-install.sh

# Run setup and PHP-FPM at runtime
CMD ["sh", "-c", "/usr/local/bin/wp-config-create.sh && chmod -R 0777 /var/www/wp-content && /usr/local/bin/wp-install.sh"]