.PHONY: help
help: ## Display this help text
	@grep -hE '^[A-Za-z0-9_ \-]*?:.*##.*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-35s\033[0m %s\n", $$1, $$2}'

.PHONY: build-dev
build-dev: ## Builds the dev docker image.
	@./devops/common/scripts/build-dev.sh

.PHONY: shell
shell: ## Starts a dev docker container (used by other commands) and execs into it.
	@./devops/common/scripts/shell.sh

.PHONY: docs
docs: ## Runs pkgsite for hosting source code documentation. 
	@./devops/common/scripts/docs.sh

.PHONY: clean
clean: ## Removes transient artifacts (dockerized).
	@./devops/common/scripts/clean.sh

.PHONY: deps
deps: ## Installs dependencies (dockerized).
	@./devops/common/scripts/deps.sh

.PHONY: deps-upgrade
deps-upgrade: ## Installs/upgrades all dependencies (dockerized).
	@./devops/common/scripts/deps-upgrade.sh

.PHONY: generate-code
generate-code: ## Generates all generated code (dockerized).
	@./devops/common/scripts/generate-code.sh

.PHONY: lint
lint: ## Runs linting (dockerized).
	@./devops/common/scripts/lint.sh

.PHONY: lint-verbose
lint-verbose: ## Runs verbose linting (dockerized).
	@./devops/common/scripts/lint-verbose.sh

.PHONY: test
test: ## Runs all tests (dockerized).
	@./devops/common/scripts/test.sh

.PHONY: generate-test-coverage
generate-test-coverage: ## Generates test coverage reports (dockerized).
	@./devops/common/scripts/generate-test-coverage.sh