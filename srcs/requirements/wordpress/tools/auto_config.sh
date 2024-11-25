#!/bin/bash

# while true
# do
#   cat
# done


if [ ! -d "/var/www/wordpress/wp-config.php" ]; then
    wp config create	--allow-root \
						--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_PASSWORD \
						--dbhost=mariadb:3306 --path='/var/www/wordpress'
fi