#!/bin/bash

# Runs all tests.
# Intended to be invoked from the repository root.

set -e

echo " * Running tests ..."
echo

CGO_ENABLED=1 go test -race ./...

echo
echo " * Done."
