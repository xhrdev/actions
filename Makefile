SHELL := bash
MAKEFLAGS += --warn-undefined-variables

.DELETE_ON_ERROR:

version = $(shell jq -r '.version' package.json)
.DEFAULT_GOAL := ci
is_ci := $(shell if [ ! -z "$(GITHUB_ACTIONS)" ]; then echo 'true'; else echo 'false'; fi)
is_release := $(shell if [ "$(GITHUB_WORKFLOW)" == 'release' ]; then echo 'true'; else echo 'false'; fi)

very-clean: clean
	rm -rf dist target node_modules/ package-lock.json
.PHONY: very-clean

clean:
	rm -rf dist target/lint
.PHONY: clean

install: | target/install
target/install:
ifeq ($(is_release), true)
	npm ci
else
	npm install
endif
	mkdir -p $(@D) && touch $@
.PHONY: install

lint: | install target/lint
target/lint:
	npm run depcheck
	mkdir -p $(@D) && touch $@
.PHONY: lint

# --- ci

ci: | install lint
.PHONY: ci
