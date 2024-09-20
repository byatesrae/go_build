#!/bin/bash

# Installs/upgrades all dependencies (dockerized).
# Intended to be invoked from the repository root.

set -e

source ./devops/common/scripts/lib/env.sh
source ./devops/common/scripts/lib/common.sh

read_env_file

if [ -z "$GOMODCACHE" ]; then
    set +e # go may not be installed, which is fine.
    GOMODCACHE=$(go env GOMODCACHE)
fi

reset_owner_of_files() {
    if [[ ! -z "$GOMODCACHE" ]]
    then
        set_owner_of_files_to_current_user $GOMODCACHE
    fi

     set_owner_of_files_to_current_user .  
}

trap reset_owner_of_files ERR

read_env_file

echo " * Running deps dockerised ..."
docker compose \
    -f ./devops/common/docker-compose.yml \
    run \
    --remove-orphans \
    --rm \
    ${GOMODCACHE:+--volume $GOMODCACHE:/go/pkg/mod} \
    dev bash "-c" "./devops/common/scripts/lib/config.sh; ./devops/common/scripts/lib/deps-upgrade.sh;"

reset_owner_of_files

echo " * Removing Docker network $(docker network rm ${COMPOSE_NETWORK})"