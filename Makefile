include .docker/.env

DC = docker compose --project-directory=.docker

.DEFAULT_GOAL      = help

.PHONY: help
help:
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' Makefile | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

### DEV
.PHONY: build init up down
build: ## Build image
	$(DC) build

init: up ## Init application
	@#$(DC) exec php composer install
	@$(DC) exec go go build -o ./bin/demo

up: ## Start the project docker containers
	@$(DC) up -d

down: ## Down the docker containers
	@$(DC) down --timeout 25

.PHONY: php-shell
php-shell: ## Run shell in php container
	@#$(DC) exec -it -u appuser php bash
	@$(DC) exec -it -u root php bash

.PHONY: go-shell
go-shell: ## Run shell in go container
	@#$(DC) exec -it -u appuser go bash
	@$(DC) exec -it -u root go bash

.PHONY: demo-run-php
demo-run-php:
	@$(DC) exec -it php sh -c "php ./demo.php"

.PHONY: demo-run-go
demo-run-go:
	@$(DC) exec -it php sh -c "./bin/go/demo"
