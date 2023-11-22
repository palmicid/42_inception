NAME		=	inception
DB_DIR		=	/home/pruangde/data
SRC_PATH	=	./srcs/



all: pre build

pre:
	@echo "create dir"
	# sudo mkdir -p $(DB_DIR)/wordpress
	# sudo mkdir -p $(DB_DIR)/mariadb

build:
	docker-compose -f ./srcs/docker-compose.yml up -d --build

start:
	docker-compose -f ./srcs/docker-compose.yml start

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

down:
	docker-compose -f ./srcs/docker-compose.yml down

.phony: clearall



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

# for test

word:
	docker build srcs/requirements/wordpress/ -t my_wordpress
	docker run --name wordp-tmp -it my_wordpress

maria:
	docker build srcs/requirements/mariadb/ -t my_mariadb
	docker run --name wmariadb-tmp -it my_mariadb

nginx:
	docker build srcs/requirements/nginx/ -t tmp_nginx
	docker run --name nginx-tmp -it -p 443:443 tmp_nginx

rmtest:
	docker rm nginx-tmp
	docker rmi tmp_nginx
