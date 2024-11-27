#!/bin/bash

# Wait for MariaDB
while ! mysqladmin ping -h"mariadb" --silent; do
    echo "Waiting for MariaDB..."
    sleep 3
done

cd /var/www/html

# Clean install if needed
if [ ! -f "wp-config.php" ] || [ ! -d "wp-content" ]; then
    rm -rf *
    
    # Install wp-cli
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    # Install WordPress
    wp core download --version=${WORDPRESS_VERSION} --allow-root
    
    # Create wp-config.php
    wp config create \
        --dbname=${SQL_DATABASE} \
        --dbuser=${SQL_USER} \
        --dbpass=${SQL_PASSWORD} \
        --dbhost=mariadb:3306 \
        --allow-root
    
    # Install WordPress core
    wp core install \
        --url=https://epolitze.42.fr \
        --title="Inception" \
        --admin_user=${WORDPRESS_DB_USER} \
        --admin_password=${WORDPRESS_DB_PASSWORD} \
        --admin_email=supervisor@example.com \
        --allow-root
        
    chown -R www-data:www-data /var/www/html
fi

exec "$@"