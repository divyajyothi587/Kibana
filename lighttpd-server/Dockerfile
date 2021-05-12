FROM akhilrajmailbox/ubuntu:16.04
MAINTAINER Akhil Raj
RUN apt-get update && apt-get install -y lighttpd lighttpd-doc \
    && apt-get install -y --allow-unauthenticated apache2-utils

ADD lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY docker_entrypoint.sh /
RUN chmod 100 /docker_entrypoint.sh