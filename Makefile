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
	@echo "\033[1;32m" # Green text
	@echo
	@docker images -a
	@echo "\033[1;34mActive docker images are: \033[0m" $(IMAGES) # Blue text for the message
	@echo
	@docker ps -a
	@echo "\033[1;34mAll docker containers are: \033[0m" $(ALL_CONTAINERS) # Blue text for the message
	@echo
	@docker volume list
	@echo "\033[1;34mAll docker volumes are: \033[0m" $(ALL_VOLUMES) # Blue text for the message
	@echo "\033[0m" # Reset colors

# Restart containers
restart:
	$(COMPOSE) restart

# Remove containers, images, networks
clean:
	@$(COMPOSE) -f $(DOCKER_FOLDER)/docker-compose.yaml down --rmi all

# Full clean: containers, volumes, images, networks
fclean:
	@$(COMPOSE) -f $(DOCKER_FOLDER)/docker-compose.yaml down --volumes --rmi all --remove-orphans
	@rm -rf /home/jaimesan/data/mariadb
	@rm -rf /home/jaimesan/data/wp_files

# Rebuild everything from scratch
re: fclean all

.PHONY: all  echo restart clean fclean