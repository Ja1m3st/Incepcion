NAME=inception
COMPOSE=docker-compose
SHELL := /bin/sh
DOCKER_FOLDER := srcs

# Build and run containers in detached mode
all: 
	@mkdir -p /home/jaimesan/data/mariadb
	@mkdir -p /home/jaimesan/data/wp_files
	@$(COMPOSE) -f $(DOCKER_FOLDER)/docker-compose.yaml up -d --build 

# Print data
echo:
	@echo
	@docker images -a
	@echo "Active docker images are: " $(IMAGES)
	@echo
	@docker ps -a
	@echo "All docker containers are: " $(ALL_CONTAINERS)
	@echo
	@docker volume list
	@echo "All docker volumes are: " $(ALL_VOLUMES)

# Restart containers
restart:
	$(COMPOSE) restart

# Remove containers, images, networks
clean:
	@$(COMPOSE) -f $(DOCKER_FOLDER)/docker-compose.yaml down --rmi all

# Full clean: containers, volumes, images, networks
fclean:
	@$(COMPOSE) -f $(DOCKER_FOLDER)/docker-compose.yaml down --volumes --rmi all --remove-orphans
	@docker image prune -f
	@rm -rf /home/jaimesan/data/mariadb
	@rm -rf /home/jaimesan/data/wp_files

# Rebuild everything from scratch
re: fclean all

.PHONY: all  echo restart clean fclean