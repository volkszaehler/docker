#!/bin/bash

set -e

echo "Waiting for database"

until mysqladmin ping -h mysql -pvolkszaehler >/dev/null 2>&1; do
	echo -n "."; sleep 1
done

echo "Validating database schema"

# mysql -u root -e "DESCRIBE aggregate;" volkszaehler >/dev/null 2>&1 || mysql -u root volkszaehler < misc/sql/schema.sql
misc/tools/doctrine orm:schema-tool:update --force

echo "Starting middleware"

vendor/bin/ppm start -c etc/middleware.json --logging 1 --static 1
