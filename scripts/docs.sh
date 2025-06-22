#!/bin/bash

# Runs pkgsite for hosting source code documentation. 
# See https://tip.golang.org/doc/comment.
# Intended to be invoked from the repository root.

set -e

source ./devops/common/scripts/lib/env.sh
source ./devops/common/scripts/lib/common.sh

read_env_file

echo " * Running docs dockerised ..."
docker compose \
    -f ./devops/common/docker-compose.yml \
    up \
    --remove-orphans \
    docs