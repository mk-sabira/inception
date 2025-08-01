FROM alpine:3.21

RUN apk update && apk upgrade && apk add --no-cache nginx gettext

COPY requirements/nginx/conf/default.conf.template /etc/nginx/http.d/default.conf.template
COPY requirements/nginx/tools/nginx-conf.sh /nginx-conf.sh

RUN chmod +x /nginx-conf.sh

EXPOSE 443

CMD ["/nginx-conf.sh"]