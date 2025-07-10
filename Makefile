# **************************************************************************** #
#                          Inception Project Makefile                         #
# **************************************************************************** #

NAME = inception
COMPOSE = docker-compose -f srcs/docker-compose.yml

all: up

up:
	@$(COMPOSE) up -d --build

down:
	@$(COMPOSE) down

clean:
	@$(COMPOSE) down --volumes --remove-orphans
	@docker rmi @$(docker images -q)

fclean: clean
	@docker rmi $$(docker images -q)

re: fclean up

.PHONY: all up down clean fclean re


