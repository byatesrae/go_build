#!/bin/bash

# Configures the dockerized environment.

set -e

echo " * Configuring env ..."
echo

go env -w GOPRIVATE=github.com/byatesrae/*

git config --global --add safe.directory /src

echo
echo " * Done."