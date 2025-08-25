.PHONY: help build up down start stop restart logs console db-console clean

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build the Docker images
	docker-compose build

up: ## Start the application (build if needed)
	docker-compose up -d

up-logs: ## Start the application and show logs
	docker-compose up

down: ## Stop the application
	docker-compose down

start: up ## Alias for up

dev: ## Start the application and follow logs
	docker-compose up -d && docker-compose logs -f

stop: down ## Alias for down

restart: ## Restart the application
	docker-compose restart

logs: ## Show application logs
	docker-compose logs -f web

db-logs: ## Show database logs
	docker-compose logs -f db

console: ## Open Rails console
	docker-compose exec web rails console

db-migrate: ## Run database migrations
	docker-compose exec web rails db:migrate

db-console: ## Open database console
	docker-compose exec db mysql -u rails -p dt_rails_development

setup: ## Initial setup - build, create database, run migrations
	docker-compose build
	docker-compose up -d db
	sleep 5
	docker-compose exec web rails db:create db:migrate

clean: ## Remove all containers
	docker-compose down -v --remove-orphans

full-clean: ## Remove all containers, networks, and volumes
	docker-compose down -v --remove-orphans
	docker system prune -f

status: ## Show status of containers
	docker-compose ps
