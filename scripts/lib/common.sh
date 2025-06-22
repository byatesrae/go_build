#!/bin/bash

# Contains common logic shared among scripts.

set -e

# Reads in the .env file.
read_env_file() {
    if [ ! -f  ".env" ]; then
        echo "ERR: \".env\" file not found."
        
        exit 1
    fi

    source .env

    export DOCS_PORT=$DOCS_PORT
}

# Will set the owner of files to the current user. Useful when a user inside a docker
# container writes files back onto the host through a mounted volume.
set_owner_of_files_to_current_user() {
    if [ -z "$1" ]; then
        echo "ERR: first argument should be a file path."        
        exit 1
    fi

    echo " * Resetting owner of files at $1..."
    docker run --rm -v $1:/workspace busybox:stable chown -R $(id -u):$(id -u) workspace
}