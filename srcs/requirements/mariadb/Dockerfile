FROM alpine:3.21

ARG DB_NAME \
    DB_USER

RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client && \
    mkdir /var/run/mysqld && \
    chown mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld && \
    rm -f /var/cache/apk/*

COPY requirements/mariadb/conf/my_custom.cnf /etc/my.cnf.d/my_custom.cnf
COPY requirements/mariadb/conf/create_db.sh /create_db.sh

RUN chmod +x /create_db.sh

EXPOSE 3306

CMD ["sh", "./create_db.sh"]