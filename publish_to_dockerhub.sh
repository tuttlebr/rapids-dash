clear
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
docker system prune -f
docker-compose build
docker-compose push