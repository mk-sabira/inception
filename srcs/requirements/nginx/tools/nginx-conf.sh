#!/bin/sh
envsubst '${DOMAIN_NAME}' < /etc/nginx/http.d/default.conf.template > /etc/nginx/http.d/default.conf
exec nginx -g "daemon off;"