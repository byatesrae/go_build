#!/bin/bash

# Runs linting.
# Intended to be invoked from the repository root.

set -e

echo " * Linting ..."
echo

$(go env GOPATH)/bin/golangci-lint run ./... -v --timeout 60m --max-issues-per-linter 50 --max-same-issues 50 --exclude-use-default=false

echo
echo " * Done."
