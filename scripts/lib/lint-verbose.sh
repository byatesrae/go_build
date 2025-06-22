#!/bin/bash

# Runs verbose linting.
# Intended to be invoked from the repository root.

set -e

echo " * Linting ..."
echo

$(go env GOPATH)/bin/golangci-lint run ./... -c ./devops/common/.golangci.verbose.yml -v --timeout 60m --max-issues-per-linter 50 --max-same-issues 50 --new

echo
echo " * Done."
