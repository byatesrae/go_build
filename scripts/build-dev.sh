#!/bin/bash

# Builds the dev docker image.
# Intended to be invoked from the repository root.

set -e

source ./devops/common/scripts/lib/env.sh
source ./devops/common/scripts/lib/common.sh

read_env_file

echo " * Rebuilding dev image ..."
docker compose -f ./devops/common/docker-compose.yml build dev

echo " * Removing Docker network $(docker network rm ${COMPOSE_NETWORK})"