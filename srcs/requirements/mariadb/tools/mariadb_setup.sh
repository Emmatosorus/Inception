#!/bin/bash

# Check if the data directory contains MariaDB's system tables to determine if initialization is required
if [ ! -d "/var/lib/mysql/\`${SQL_DATABASE}\`" ]; then
    echo "MariaDB database already exists"
else 
    if [ ! -d "/var/lib/mysql/mysql" ]; then
      # Run the initial database setup only if the database is not initialized
      echo "Initializing MariaDB database..."
      mariadb-install-db --user=mysql --basedir=/usr --ldata=/var/lib/mysql
    fi
fi

# # Start the MariaDB server in the background (safe mode for initial setup)
# echo "Starting MariaDB server..."
# mysqld_safe --skip-networking --user=mysql &

# # Wait for MariaDB server to start up
# echo "Waiting for MariaDB to start..."
# until mysqladmin ping --host=localhost --user=root --password="" --silent; do
#   echo "Waiting for MariaDB to respond..."
#   sleep 1
# done

# Log in as root and execute the SQL commands
echo "Setting up database and user..."
mysql --user=root --password="" <<EOF
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

exec $@