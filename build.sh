#!/bin/sh
TARGET=/to_host

# builder image
docker build -t build ./build 

# prepare sources 
docker run -v $(pwd)/dist:$TARGET -t build git clone https://github.com/volkszaehler/volkszaehler.org $TARGET
docker run -v $(pwd)/dist:$TARGET -t build php composer.phar install -d $TARGET --optimize-autoloader --no-dev

# runtime image
if [ -z $1 ] || [ "$1" !== "build" ] ; then
docker build -t andig/volkszaehler:debian -f ./debian/Dockerfile .
docker build -t andig/volkszaehler:raspbian -f ./raspbian/Dockerfile .
fi
