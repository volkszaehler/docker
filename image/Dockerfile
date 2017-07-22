FROM debian:stretch-slim

MAINTAINER Andreas Goetz <cpuidle@gmx.de>

ENV DEBIAN_FRONTEND noninteractive
ENV DOCKERIZE_VERSION v0.5.0

ENV TARGET /usr/local/volkszaehler
ENV PHP_VER 7.0

# prepare

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends wget ca-certificates

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# install runtime environment

RUN apt-get install -y --no-install-recommends php${PHP_VER}-cgi php${PHP_VER}-opcache php${PHP_VER}-mysql php${PHP_VER}-xml php${PHP_VER}-zip php${PHP_VER}-mbstring
# RUN apt-get install -y --no-install-recommends apache2
# RUN rm -rf /var/lib/apt/lists/*

# configure environment

RUN sed -i "s/^.*opcache.enable_cli=.*/opcache.enable_cli=1/" /etc/php/${PHP_VER}/cli/php.ini
RUN sed -i "s/^.*opcache.enable=.*/opcache.enable=1/" /etc/php/${PHP_VER}/cgi/php.ini
RUN sed -i -re 's/^.*(disable_functions.*)/;\1/' /etc/php/${PHP_VER}/cgi/php.ini

# RUN a2enmod proxy proxy_http proxy_wstunnel rewrite

COPY volkszaehler ${TARGET}
COPY volkszaehler.conf.php ${TARGET}/etc
COPY ProcessSlave.php ${TARGET}/vendor/php-pm/php-pm
COPY options.js ${TARGET}/htdocs/js

# runtime

WORKDIR ${TARGET}
CMD [ "vendor/bin/ppm", "start", "-c", "etc/middleware.json", "--logging", "1", "--static", "1" ]
