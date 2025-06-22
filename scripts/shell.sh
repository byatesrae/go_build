#!/bin/bash

# Starts a dev docker container and execs into it.
# Intended to be invoked from the repository root.

set -e

source ./devops/common/scripts/lib/env.sh
source ./devops/common/scripts/lib/common.sh

read_env_file

echo " * Exec into dev container ..."
docker compose \
    -f ./devops/common/docker-compose.yml \
    run \
    --interactive \
    --remove-orphans \
    --rm \
    dev

echo " * Removing Docker network $(docker network rm ${COMPOSE_NETWORK})"
