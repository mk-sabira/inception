FROM alpine:3.21

# Define build arguments (removed password args)
ARG DB_NAME \
    DB_USER

# Install MariaDB and set up runtime directory
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client && \
    mkdir /var/run/mysqld && \
    chown mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld && \
    rm -f /var/cache/apk/*

# Copy configuration and setup script
COPY requirements/mariadb/conf/my_custom.cnf /etc/my.cnf.d/my_custom.cnf
COPY requirements/mariadb/conf/create_db.sh /create_db.sh

# CHANGE: Removed ARG for DB_PASS and DB_ROOT, as create_db.sh uses secrets
RUN chmod +x /create_db.sh

# Expose MariaDB port
EXPOSE 3306

# Run initialization and MariaDB server
CMD ["sh", "./create_db.sh"]