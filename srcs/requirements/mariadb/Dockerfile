FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt install mariadb-server -y

RUN mkdir -p /var/lib/mysql

COPY tools/mariadb_setup.sh /usr/local/bin/mariadb_setup.sh
RUN chmod +x /usr/local/bin/mariadb_setup.sh

RUN chown -R mysql:mysql /var/lib/mysql

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/usr/local/bin/mariadb_setup.sh"]
CMD ["mysqld", "--bind-address=0.0.0.0"]