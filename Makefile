#
# Makefile for this application
#

OK_COLOR=\033[32;01m
NO_COLOR=\033[0m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m

REPO_URL ?= grengojbo
TAG=$(shell cat VERSION)

OSNAME=$(shell uname)

CUR_TIME=$(shell date '+%Y-%m-%d_%H:%M:%S')
# Program version
VERSION=$(shell cat VERSION)

# Binary name for bintray
BIN_NAME=$(shell basename $(abspath ./))

# Project name for bintray
PROJECT_NAME=$(shell basename $(abspath ./))
PROJECT_DIR=$(shell pwd)

# Project url used for builds
# examples: github.com, bitbucket.org
REPO_HOST_URL=github.com.org

# Grab the current commit
GIT_COMMIT="$(shell git rev-parse HEAD)"


default: help

help:
	@echo "..............................................................."
	@echo "Project: $(PROJECT_NAME) | current dir: $(PROJECT_DIR)"
	@echo "version: $(VERSION)\n"
	@echo "make build    - Build Docker image"
	@echo "make push     - Push Docker image"
	@echo "make clean    - Clean local Docker image"
	@echo "...............................................................\n"


clean:
	docker rmi -f $(REPO_URL)/$(PROJECT_NAME):$(TAG)
	docker system prune -f

push:
	docker push $(REPO_URL)/$(PROJECT_NAME):$(TAG)

push-buildr:
	docker push $(REPO_URL)/$(REPO_URL)/caddy:builder

pull:
	docker pull $(REPO_URL)/$(PROJECT_NAME):${TAG}

build-builder:
	docker build --tag=$(REPO_URL)/caddy:builder ./builder/

build:
	docker build --tag=$(REPO_URL)/$(PROJECT_NAME):$(TAG) .

# Attach a root terminal to an already running dev shell
shell: pull
	docker run -it --rm $(REPO_URL)/$(PROJECT_NAME):$(TAG) zsh

version:
	@echo ${VERSION}