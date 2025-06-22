#!/bin/bash

# Builds the dev docker image.
# Intended to be invoked from the repository root.

set -e

source ./devops/common/scripts/lib/env.sh
source ./devops/common/scripts/lib/common.sh

read_env_file

echo " * Rebuilding gcp image ..."
docker build \
  --tag ${PROJECT_NAME}-gcp:${GIT_SHA} \
  ./devops/common/docker/firestore/.