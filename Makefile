SHELL=/bin/bash
DOCKER=/usr/local/bin/docker
DOCKER-COMPOSE=/usr/local/bin/docker-compose

# Configurable variables
DIST=./balancer
DOCKER-FILE=Dockerfile
DOCKER-REPO=jjperezaguinaga/balancer
DOCKER-REGISTRY=tutum.co

build-image:
	$(DOCKER) build -t=$(DOCKER-REPO) -f=balancer/Dockerfile $(DIST)

build: build-image

run-docker:
	$(DOCKER-COMPOSE) up -d

run: build run-docker

deploy-docker:
	# Assumes docker login
	$(DOCKER) tag -f $(DOCKER-REPO) $(DOCKER-REGISTRY)/$(DOCKER-REPO)
	$(DOCKER) push $(DOCKER-REGISTRY)/$(DOCKER-REPO)

deploy: deploy-docker

production: build deploy

# setup-dev:
	# Assumes Docker-machine, see Issue #2
	# docker-machine create --driver virtualbox jjperezaguinaga.com-dev
	# Allow execution of following within Makefile, see Issue #3
	# eval "$(docker-machine env jjperezaguinaga.com-dev)"

