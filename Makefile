SHELL=/bin/bash

setup:
	npm install

setup-dev:
	# Assumes Docker-machine, see Issue #2
	docker-machine create --driver virtualbox jjperezaguinaga.com-dev
	# Allow execution of following within Makefile, see Issue #3
	# eval "$(docker-machine env jjperezaguinaga.com-dev)"

build-index:
	cd ./node_modules/index.jjperezaguinaga.com
	$(MAKE)
