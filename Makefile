NGINX_PATH = ./srcs/requirements/nginx

COMPOSE_FILE = srcs/docker-compose.yml


# docker build $(NGINX_PATH) -t nginx
# docker run -it nginx

all:
	docker compose -f $(COMPOSE_FILE) up --build
