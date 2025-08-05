#!/bin/sh

if [ -z "${DB_NAME}" ]; then
    echo "Error: DB_NAME is not set"
    exit 1
fi

DB_ROOT=$(cat /run/secrets/db_root_password)
DB_PASS=$(cat /run/secrets/db_password)

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db
    mariadbd --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
FLUSH PRIVILEGES;
EOF
fi

exec mariadbd --user=mysql --port=3306 --bind-address=0.0.0.0