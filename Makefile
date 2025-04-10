
# Regular Colors
BLACK       = \033[30m
RED         = \033[31m
GREEN       = \033[32m
YELLOW      = \033[33m
BLUE        = \033[34m
MAGENTA     = \033[35m
CYAN        = \033[36m
WHITE       = \033[37m
LIGHT_PINK  = \033[38;5;168m
NC          = \033[0m   # No Color (Reset)

# Other Formatting
UNDERLINE   = \033[4m
REVERSED    = \033[7m
BLINK       = \033[5m
ITALIC      = \033[3m
STRIKE      = \033[9m
CLEAR_LINE  = \033[2K\r

all: container

container-build:
	@if ! docker ps | grep -q dev_container; then \
		printf "$(YELLOW)🚧 Building the container environment 🚧 $(NC)\n"; \
		docker compose -f ./docker-compose.yml build --no-cache; \
	else \
		printf "$(YELLOW)🚧 Container already built.. skip build process 🚧 $(NC)\n"; \
	fi

container-up:
	@if ! docker ps | grep -q dev_container; then \
		printf "$(YELLOW)🚧 Starting the container environment 🚧 $(NC)\n"; \
		docker compose -p dev_container -f ./docker-compose.yml up -d; \
	else \
		printf "$(YELLOW)🚧 Container already running.. skip its creation 🚧 $(NC)\n"; \
	fi

container:
	@make container-build
	@make container-up
	@docker exec -it -w /app dev_container bash

prune:
	@if docker ps -a | grep -q dev_container; then \
		printf "$(RED)🚧 Removing existing container... 🚧 $(NC)\n"; \
		docker stop dev_container > /dev/null 2>&1 && docker rm dev_container > /dev/null 2>&1; \
	else \
		printf "$(YELLOW)🚧 No container named 'dev_container' to remove. 🚧 $(NC)\n"; \
	fi
	@printf "$(GREEN)✅ All done! ✅$(NC)\n"


# Phony targets
.PHONY: container-build container-up container prune