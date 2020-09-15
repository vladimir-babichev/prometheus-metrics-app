ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

IMAGE_TAG ?= latest
IMAGE_NAME ?= vbabichev/$(shell basename $(ROOT_DIR))
VERSION := $(shell cat $(ROOT_DIR)/app/VERSION)

.PHONY: build
build:
	docker build --build-arg VERSION=$(VERSION) -t $(IMAGE_NAME):$(IMAGE_TAG) -f $(ROOT_DIR)/Dockerfile $(ROOT_DIR)/app/
