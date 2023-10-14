all: up

up: 
	docker-compose up --build

prod:
	docker-compose -f docker-compose-ssr-prod.yml up --build

down:
	docker-compose down

clean:
	@echo "removing project's heavy dependencies..."
	rm -rf march-backend/dist march-frontend/dist march-backend/package-lock.json
	rm -rf march-frontend/package-lock.json

restart: clean run

reset: down clean
	@echo "removing all docker volumes..."
	@docker volume rm $(shell docker volume ls -q) 2> /dev/null || true

back:
	docker exec -it backend sh

front:
	docker exec -it frontend sh

push:
	git add *
	git commit -m "$(M)"
	git push
