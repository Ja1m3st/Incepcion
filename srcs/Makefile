NAME=inception
COMPOSE=docker-compose

.PHONY: all up down start stop restart clean fclean

# build and run containers in detached mode
all: up

up:
	$(COMPOSE) up -d --build

# stop containers
stop:
	$(COMPOSE) stop

# start containers (without rebuilding)
start:
	$(COMPOSE) start

# restart containers
restart:
	$(COMPOSE) restart

# stop and remove containers, networks, but keep volumes
down:
	$(COMPOSE) down

# remove containers and volumes
clean:
	$(COMPOSE) down -v

# full clean: containers, volumes, images, networks
fclean:
	$(COMPOSE) down 

# rebuild everything from scratch
re: fclean all