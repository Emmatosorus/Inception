COMPOSE_FILE = srcs/docker-compose.yml

all:
	mkdir -p /home/${USER}/data/wordpress
	mkdir -p /home/${USER}/data/mariadb
	chown -R ${USER}:${USER} /home/${USER}/data/
	chmod 755 /home/${USER}/data/
	docker compose -f $(COMPOSE_FILE) up --build

start:
	docker compose -f $(COMPOSE_FILE) up

stop:
	docker compose -f $(COMPOSE_FILE) stop

fclean:
	docker compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	docker system prune --all --volumes --force
	rm -rf /home/${USER}/data/mariadb
	rm -rf /home/${USER}/data/wordpress

re: fclean all