
# docker

Docker image for volkszaehler middleware and frontend

# Running

To run this image simply pull the built version from docker hub (https://hub.docker.com/r/andig/volkszaehler/):

	docker pull andig/volkszaehler

The image expects a mysql database with standard volkszaehler credentials:

      - HOST=mysql
      - MYSQL_ROOT_PASSWORD=volkszaehler
      - MYSQL_DATABASE=volkszaehler
      - MYSQL_USER=vz
      - MYSQL_PASSWORD=demo

This setup is already available by using the pre-composed `docker-compose.yml` configuration consisting of MySQL database and volkszaehler runtime:

	docker-composer up

# Building

Simply run the build script:

	./build.sh

It will pull the sources, then build the image and configure the database schema. Building requires `git`, `composer` and `php` to be installed locally.
