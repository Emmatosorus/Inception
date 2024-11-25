FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y

RUN mkdir /script

RUN apt install mariadb-server -y

RUN /etc/init.d/mariadb start

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mariadb_setup.sh	/script

RUN chmod +x /script/mariadb_setup.sh

ENTRYPOINT [ "/script/mariadb_setup.sh" ]
CMD ["mysqld_safe"]



