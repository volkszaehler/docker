FROM debian:stretch-slim

MAINTAINER Andreas Goetz <cpuidle@gmx.de>

ENV DEBIAN_FRONTEND noninteractive
ENV PHP_VER 7.0
ENV TARGET=/dist

# prepare

RUN apt-get update 
RUN apt-get upgrade -y --no-install-recommends
RUN apt-get install -y --no-install-recommends git php7.0
RUN apt-get install -y --no-install-recommends wget ca-certificates

ENV DOCKERIZE_VERSION v0.5.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# install runtime environment

RUN apt-get install -y --no-install-recommends php${PHP_VER}-cgi php${PHP_VER}-opcache php${PHP_VER}-mysql php${PHP_VER}-xml php${PHP_VER}-zip php${PHP_VER}-mbstring

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
