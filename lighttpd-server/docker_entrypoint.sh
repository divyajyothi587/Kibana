#!/bin/bash

if [[ ! -z "${BASIC_AUTH_USER}" ]] && [[ ! -z "${BASIC_AUTH_PASS}" ]] && [[ ! -z ${PROXY_PORT} ]] ; then
	sed -i "s|PROXY_PORT|${PROXY_PORT}|g" /etc/lighttpd/lighttpd.conf
	htpasswd -b -c /etc/lighttpd/.htpasswd  ${BASIC_AUTH_USER} ${BASIC_AUTH_PASS}
	lighttpd -D -f /etc/lighttpd/lighttpd.conf
else
	echo "BASIC_AUTH_USER, BASIC_AUTH_PASS and PROXY_PORT need to provide"
	echo "task aborting.....!"
	exit 1
fi