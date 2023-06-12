#!/bin/bash

# Runs ./build/scripts/generate-test-coverage.sh dockerized.
# Intended to be invoked from the repository root.

set -e

source ./build/scripts/docker/common.sh

read_env_file

trap reset_owner_of_files ERR

echo " * Running clean dockerised ..."
docker run \
    --rm \
    -v ${PWD}:/src \
    --env-file=.env \
    --workdir="/src" \
    --entrypoint /bin/bash \
    coverto/go_build:v1.2.0 \
    "-c" "./build/scripts/docker/config.sh; ./build/scripts/generate-test-coverage.sh;" 

reset_owner_of_files