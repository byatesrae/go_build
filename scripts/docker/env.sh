#!/bin/bash

# Runs ./build/scripts/env.sh dockerized.
# Intended to be invoked from the repository root.

set -e

source ./build/scripts/docker/common.sh

read_env_file

trap reset_owner_of_files ERR

echo " * Running env dockerised ..."
docker run \
    --rm \
    -v ${PWD}:/src \
    --env-file=.env \
    --workdir="/src" \
    --entrypoint /bin/bash \
    coverto/go_build:v1.2.0 \
    "-c" "./build/scripts/docker/config.sh; ./build/scripts/env.sh;" 

reset_owner_of_files