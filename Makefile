SHELL=/bin/bash

.DEFAULT_GOAL := build-index

DOCKER=/usr/local/bin/docker

# Configurable variables
DIST=./balancer
DOCKER-FILE=Dockerfile
DOCKER-REPO=jjperezaguinaga/balancer
DOCKER-REGISTRY=tutum.co

build-balancer:
	$(DOCKER) build -t=$(DOCKER-REPO) -f=balancer/Dockerfile $(DIST)

deploy-docker:
	# Assumes docker login
	$(DOCKER) tag -f $(DOCKER-REPO) $(DOCKER-REPO)
	$(DOCKER) push $(DOCKER-REPO)

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
