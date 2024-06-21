# Makefile for acronyms
# Tested with GNU Make 3.81
MAKEFLAGS += --warn-undefined-variables
SHELL        	:= /usr/bin/env bash -e
.DEFAULT_GOAL := help

INSTALL_STAMP := .install.stamp
POETRY := $(shell command -v poetry 2> /dev/null)
# cribbed from https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html and https://news.ycombinator.com/item?id=11195539
help:  ## Prints out documentation for available commands
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST)

install: $(INSTALL_STAMP)  ## Install dependencies
$(INSTALL_STAMP): pyproject.toml poetry.lock
	@echo $(POETRY)
	@if [ -z $(POETRY) ]; then echo "Poetry could not be found. See https://python-poetry.org/docs/"; exit 2; fi
	"$(POETRY)" --version
	"$(POETRY)" install
	touch $(INSTALL_STAMP)

## Test targets
.PHONY: test
test: $(INSTALL_STAMP) unit-test lint  ## Run tests and lint checks

.PHONY:  unit-test
unit-test: $(INSTALL_STAMP)  ## Run python unit tests
	"$(POETRY)" run pytest -v --cov --cov-report term --cov-report html

.PHONY: lint
lint: $(INSTALL_STAMP)  ## Lint code base
	"$(POETRY)" run ruff check
	"$(POETRY)" run ruff format --check

.PHONY: format
format: $(INSTALL_STAMP)  ## Format code base
	"$(POETRY)" run ruff check --fix
	"$(POETRY)" run ruff format

.PHONY: format-acronyms
format-acronyms:  ## Formats acronyms file, cleaning up smart quotes and capitalization. Results written to STDOUT
	"$(POETRY)" run format_acronyms

#Ruby
.PHONY: csvlint-install
csvlint-install:  ## Install csvlint
	bundle install

.PHONY: csvlint
csvlint:  ## Runs csvlint on acronyms file
	bundle exec csvlint acronyms.csv

# Other tools
.PHONY: dupe-acronyms
dupe-acronyms:  ## prints out duplicated acronyms
	@cd scripts; \
	./print-dupe-acronyms.sh

.PHONY: dupe-definitions
dupe-definitions:  ## prints out duplicated definitions
	@cd scripts; \
	./print-dupe-definitions.sh

# spelling
.PHONY: spelling-tool-install
spelling-tool-install:  ## Installs spelling tools (only works on OSX for now)
	./scripts/install-spelling-tools.sh

.PHONY: spelling-check
spelling-check:  ## Checks spelling with hunspell
	@cd scripts; \
	./check-spelling.sh
	
.PHONY: clean
clean: ## Delete any directories, files or logs that are auto-generated and python packages
	rm -rf results .ruff_cache .pytest_cache
	rm -f $(INSTALL_STAMP) .coverage
	find . -type d -name "__pycache__" | xargs rm -rf {};
