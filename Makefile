all: build

build:
	docker-compose -f ./srcs/docker-compose.yml up --build -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean:
	@echo "Stopping and removing all containers..."
	docker stop $$(docker ps -aq) || true
	docker rm $$(docker ps -aq) || true

	@echo "Removing all images..."
	docker rmi $$(docker images -q) || true

	@echo "Removing all volumes..."
	docker volume rm $$(docker volume ls -q) || true

	@echo "Removing all networks..."
	docker network rm $$(docker network ls -q) || true

re: clean all
