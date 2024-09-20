 #!/bin/bash

# Builds the services defined in the root docker-compose.yml for multiple platforms
# and pushes them to the registry.
# Note: we cannot build a multi platform image without pushing. See https://github.com/docker/buildx/issues/59.

set -e

source ./devops/common/scripts/lib/env.sh

echo " * Building ..."

set +e # Check to see if the builder exists
docker buildx inspect $PROJECT_NAME > /dev/null

buildxInspectExitStatus=$?
if [ $buildxInspectExitStatus -ne 0 ] # if non-zero, builder does not exist
then
    docker buildx create --bootstrap --use --name $PROJECT_NAME
fi

docker buildx bake --push