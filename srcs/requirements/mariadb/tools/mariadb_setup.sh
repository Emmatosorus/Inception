#!/bin/bash

# Start MariaDB in background
mysqld_safe --skip-networking &
sleep 5

# Run initialization commands
mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOSQL

# Stop background service
mysqladmin --user=root --password=${SQL_ROOT_PASSWORD} shutdown

# Start MariaDB in foreground
exec mysqld --bind-address=0.0.0.0