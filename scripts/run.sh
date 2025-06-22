#!/bin/bash

# Runs the services defined in docker-compose.yml.
# Intended to be invoked from the repository root.

set -e

source ./devops/common/scripts/lib/env.sh

echo " * Running platform container ..."

# Ignore exit status as it may simply be interrupted with ctrl+c.
set +e
docker compose up --remove-orphans

dockerComposeUpExitStatus=$?

echo " * Docker Compose exited($dockerComposeUpExitStatus)..."

# If docker compose was not interrupted with ctrl+c.
if [ $dockerComposeUpExitStatus -ne 130 ] && [ $dockerComposeUpExitStatus -ne 0 ]; then
    exit $dockerComposeUpExitStatus
fi

echo " * Cleaning up platform container ..."
docker compose down