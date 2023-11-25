NAME		=	inception
DB_DIR		=	/home/pruangde/data
SRC_PATH	=	./srcs/



all: pre build

pre:
	@echo "create dir"
	sudo mkdir -p $(DB_DIR)/wordpress
	sudo mkdir -p $(DB_DIR)/mariadb

build: 
	docker compose -f ./srcs/docker-compose.yml up -d --build

start:
	docker compose -f ./srcs/docker-compose.yml start

stop:
	docker compose -f ./srcs/docker-compose.yml stop

down:
	docker compose -f ./srcs/docker-compose.yml down --remove-orphans

clean: down
	@sudo rm -rf $(DB_DIR)

fclean: down clean
	docker system prune -af --volumes
	docker volume rm $$(docker volume ls -q)
	docker network rm $$(docker network ls -q)

re: fclean all

.phony: all build start stop down rmall




# TESTING PART

rmall: dstop rm rmi rmvlo rmnet

ls:
	@echo "================================================================================"
	docker ps -a
	@echo "================================================================================"
	docker image ls
	@echo "================================================================================"
	docker volume ls
	@echo "================================================================================"
	docker network ls
	@echo "================================================================================"
# dont forget to delete before submit
dstop:
	-docker stop $$(docker ps -qa)

rm:
	-docker rm $$(docker ps -qa)

rmi:
	-docker image rm -f $$(docker image ls -q)

rmvol:
	-docker voloume rm $$(docker volume ls -q)

rmnet:
	-docker network rm $$(docker networks ls -q) 2>/dev/null


