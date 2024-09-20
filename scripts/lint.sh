#!/bin/bash

# Runs linting (dockerized).
# Intended to be invoked from the repository root.

set -e

source ./devops/common/scripts/lib/env.sh
source ./devops/common/scripts/lib/common.sh

read_env_file

if [ -z "$GOCACHE" ]; then
    set +e # go may not be installed, which is fine.
    GOCACHE=$(go env GOCACHE)
fi

reset_owner_of_files() {
    if [[ ! -z "$GOCACHE" ]]
    then
        set_owner_of_files_to_current_user $GOCACHE
    fi    
}

trap reset_owner_of_files ERR

echo " * Running lint dockerized ..."
docker compose \
    -f ./devops/common/docker-compose.yml \
    run \
    --remove-orphans \
    --rm \
    ${GOCACHE:+--volume $GOCACHE:/root/.cache/go-build} \
    --env GOLANGCI_LINT_CACHE=/root/.cache/go-build \
    dev ./devops/common/scripts/lib/lint.sh

reset_owner_of_files

echo " * Removing Docker network $(docker network rm ${COMPOSE_NETWORK})"