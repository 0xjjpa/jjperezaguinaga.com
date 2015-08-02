SHELL=/bin/bash

.DEFAULT_GOAL := build-index

setup:
	npm install

setup-dev:
	# Assumes Docker-machine, see Issue #2
	docker-machine create --driver virtualbox jjperezaguinaga.com-dev
	# Allow execution of following within Makefile, see Issue #3
	# eval "$(docker-machine env jjperezaguinaga.com-dev)"

build-index:
	$(MAKE) -C ./node_modules/index.jjperezaguinaga.com

build-articles:
	$(MAKE) -C ./node_modules/articles.jjperezaguinaga.com

build: build-index build-articles
