#!/bin/bash

mysqld_safe --skip-networking &
sleep 5

mysql --user=root --password=${SQL_ROOT_PASSWORD} <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOSQL

mysqladmin --user=root --password=${SQL_ROOT_PASSWORD} shutdown

exec mysqld --bind-address=0.0.0.0