#!/bin/bash

# Configures the env for script & docker compose invocations.
# Intended to be invoked from the repository root.

set -e

export PROJECT_DIRECTORY=$PWD

export GIT_SHA=$(git rev-parse HEAD) # Will complain if git repository is empty, requiring at least 1 commit.
if [[ $(git diff --stat) != '' ]]; then
  GIT_SHA=$GIT_SHA-dirty
fi

# Example name - "my-project-dev".
export PROJECT_NAME=$(basename -s .git $(git remote get-url origin))

# Give a name unique to the process invoking compose. That way concurrent compose 
# invocations from separate processes are isolated. Also, some random characters 
# are required as concurrent containers may have overlapping script process IDs ($$)
# which can cause issues in environments such as Cloud Build.
# Example name - "55502-yh0o42v0u1htp-shopping-insights-dev". 
# See https://docs.docker.com/compose/environment-variables/envvars/#compose_project_name
export COMPOSE_PROJECT_NAME=$$-$(tr -dc a-z0-9 </dev/urandom | head -c 13 ; echo '')-$PROJECT_NAME-dev

export COMPOSE_NETWORK=${COMPOSE_PROJECT_NAME}

if [ ! -f  ".env" ]; then
    echo " * Creating default .env file ..."
    echo    
    echo " * Don't forget to replace the \"FILL_IN_MANUALLY\" values in your new .env file."

    cp -n ./.env.local.example ./.env

    echo
    echo " * Done."
fi
