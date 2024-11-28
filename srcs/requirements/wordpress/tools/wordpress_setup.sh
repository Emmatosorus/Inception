#!/bin/bash

while ! mysqladmin ping -h"mariadb" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

cd /var/www/html

if [ ! -f "wp-config.php" ] || [ ! -d "wp-content" ]; then
    rm -rf *
    
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    wp core download --version=${WORDPRESS_VERSION} --allow-root
    
    wp config create \
        --dbname=${SQL_DATABASE} \
        --dbuser=${SQL_USER} \
        --dbpass=${SQL_PASSWORD} \
        --dbhost=${WORDPRESS_DB_HOST} \
        --allow-root
    
    wp core install \
        --url=https://epolitze.42.fr \
        --title="Kill me now" \
        --admin_user=${WORDPRESS_DB_USER} \
        --admin_password=${WORDPRESS_DB_PASSWORD} \
        --admin_email=supervisor@example.com \
        --allow-root
        
    chown -R www-data:www-data /var/www/html
fi

exec "$@"