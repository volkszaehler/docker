#!/bin/sh

TARGET=image/volkszaehler

# get and configure sources
git clone https://github.com/volkszaehler/volkszaehler.org ${TARGET} || git -C ${TARGET} pull
composer install -d ${TARGET} --optimize-autoloader --no-dev

# build image
docker build -t volkszaehler ./image
docker images volkszaehler

# setup database
docker-compose run volkszaehler misc/tools/doctrine orm:generate-proxies
docker-compose run volkszaehler dockerize -wait tcp://mysql:3306 misc/tools/doctrine orm:schema-tool:drop --force
docker-compose run volkszaehler dockerize -wait tcp://mysql:3306 misc/tools/doctrine orm:schema-tool:create

echo Use the following command to start the runtime:
echo docker-compose up
