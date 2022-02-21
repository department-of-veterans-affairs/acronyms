# Makefile for Performance dashboard
# Tested with GNU Make 3.81
MAKEFLAGS += --warn-undefined-variables
SHELL        	:= /usr/bin/env bash -e
CI_ARG      	:= $(CI)
.DEFAULT_GOAL := help

# cribbed from https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html and https://news.ycombinator.com/item?id=11195539
help:  ## Prints out documentation for available commands
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST)

# brew
.PHONY: spelling-tool-install
spelling-tool-install:  ## Installs spelling tools (only works on OSX for now)
ifneq ($(CI_ARG), true)
	./scripts/install-spelling-tools.sh
endif

## Pip / Python
.PHONY: python-install
# python-install recipe all has to run in a single shell because it's running inside a virtualenv
python-install:  ## Sets up your python environment for the first time (only need to run once)
ifeq ($(CI_ARG), true)
	pip --no-cache-dir install -r scripts/requirements.txt -r scripts/dev-requirements.txt
else
	python3 -m venv ./venv ;\
	source venv/bin/activate ;\
	echo shell venv activated ;\
	pip install -r scripts/requirements.txt -r scripts/dev-requirements.txt ;\
	echo Finished python install ;\
	echo Please activate the virtualenvironment with: ;\
	echo source venv/bin/activate
endif

# Errors out if VIRTUAL_ENV is not defined and we aren't in a CI environment.
.PHONY: check-env
check-env:
ifndef VIRTUAL_ENV
ifneq ($(CI_ARG), true)
	$(error VIRTUAL_ENV is undefined, meaning you aren't running in a virtual environment. Fix by running: 'source venv/bin/activate')
endif
endif

# Because of this bug we have to turn an absolute path to relative one. Relies on the repository name
# https://github.com/jazzband/pip-tools/issues/204
scripts/requirements.txt: scripts/requirements.in
	pip-compile scripts/requirements.in --output-file $@

scripts/dev-requirements.txt: scripts/dev-requirements.in
	pip-compile scripts/dev-requirements.in --output-file $@

.PHONY: pip-upgrade
pip-upgrade:  ## Upgrade all python dependencies
	pip-compile --upgrade scripts/requirements.in --output-file scripts/requirements.txt
	pip-compile --upgrade scripts/dev-requirements.in --output-file scripts/dev-requirements.txt

SITE_PACKAGES := $(shell pip show pip | grep '^Location' | cut -f2 -d ':')
$(SITE_PACKAGES): scripts/requirements.txt scripts/dev-requirements.txt check-env
ifeq ($(CI_ARG), true)
	@echo "Do nothing; assume python dependencies were installed already"
else
	pip-sync scripts/requirements.txt scripts/dev-requirements.txt
endif

.PHONY: pip-install
pip-install: $(SITE_PACKAGES)

## Test targets
.PHONY: unit-test
unit-test:  pip-install   ## Run python unit tests
	PYTHONPATH=scripts \
	python -m pytest -v --cov --cov-report term --cov-report xml --cov-report html --cov-fail-under=50

.PHONY: flake8
flake8: pip-install 	## Run Flake8 python static style checking and linting
	@echo "flake8 comments:"
	flake8 --statistics scripts

.PHONY: test
test: unit-test flake8   ## Run unit tests, static analysis
	@echo "All tests passed."  # This should only be printed if all of the other targets succeed

.PHONY: clean
clean: ## Delete any directories, files or logs that are auto-generated and python packages
	rm -rf venv
	rm -rf results
	rm -rf .pytest_cache
	rm -f .coverage
	# We keep spark-distro as this is committed to git
	find python -name '__pycache__' -type d | xargs rm -rf
	@echo virtualenvironment was deleted. Type 'deactivate' to deactivate the shims.
	@echo Run 'make python-install' to reinstall the virtual environment.
