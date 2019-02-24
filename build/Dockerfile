FROM debian:stretch-slim

MAINTAINER Andreas Goetz <cpuidle@gmx.de>

ARG PHP_VER=7.0

ENV DEBIAN_FRONTEND noninteractive

# install runtime environment

RUN apt-get -q update && \
    apt-get -qy --no-install-recommends install \
	php${PHP_VER}-cli \
	php${PHP_VER}-mysql \
	php${PHP_VER}-xml \
	php${PHP_VER}-zip \
	git \
	ca-certificates \
	wget
 
RUN EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)" && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")" && \
    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then >&2 echo 'ERROR: Invalid installer signature'; rm composer-setup.php; exit 1; fi

RUN php composer-setup.php --quiet && \
    rm composer-setup.php
