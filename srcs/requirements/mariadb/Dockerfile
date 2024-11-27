FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt install mariadb-server -y

# Create directory for volume
RUN mkdir -p /var/lib/mysql

# Copy the initialization script
COPY tools/mariadb_setup.sh /usr/local/bin/mariadb_setup.sh
RUN chmod +x /usr/local/bin/mariadb_setup.sh

# Set proper permissions
RUN chown -R mysql:mysql /var/lib/mysql

# Define volume mount point
VOLUME ["/var/lib/mysql"]

# Expose the default MySQL port
EXPOSE 3306

# Use the custom initialization script
ENTRYPOINT ["/usr/local/bin/mariadb_setup.sh"]
CMD ["mysqld", "--bind-address=0.0.0.0"]