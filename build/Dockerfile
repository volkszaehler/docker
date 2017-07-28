FROM debian:stretch-slim

MAINTAINER Andreas Goetz <cpuidle@gmx.de>

ARG PHP_VER=7.0

ENV DEBIAN_FRONTEND noninteractive

# install runtime environment

RUN apt-get -q update
RUN apt-get -qy --no-install-recommends install \
	php${PHP_VER}-cli \
	php${PHP_VER}-mysql \
	php${PHP_VER}-xml \
	php${PHP_VER}-zip \
	git \
	ca-certificates

# composer

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
