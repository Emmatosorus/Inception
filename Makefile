COMPOSE_FILE = srcs/docker-compose.yml

all:
	docker compose -f $(COMPOSE_FILE) up --build

start:
	docker compose -f $(COMPOSE_FILE) up

stop:
	docker compose -f $(COMPOSE_FILE) stop

fclean:
	docker compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	docker system prune --all --volumes --force

re: fclean all