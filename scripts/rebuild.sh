#!/bin/bash

# Rebuilds the services defined in docker-compose.yml.
# Intended to be invoked from the repository root.

set -e

if [[ $(git diff --stat) == '' ]]; then
        # Images are tagged with a commit SHA if there are no changes since the commit. These
        # don't need to be rebuilt.
        echo "ERR: Only use this command to rebuild an existing image if you've made changes since it was built."        
        exit 1
fi

source ./devops/common/scripts/lib/env.sh

echo " * Rebuilding ..."

docker compose build

echo " * Done! Consider pruning dangling images with \`docker image prune\`."