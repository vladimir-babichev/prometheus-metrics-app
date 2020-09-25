ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
APP_NAME := $(shell echo $(ROOT_DIR) | sed 's/.*\///; s/prometheus-//')

IMAGE_TAG ?= latest
IMAGE_NAME ?= vbabichev/$(APP_NAME)
VERSION := $(shell cat $(ROOT_DIR)/src/VERSION)

.PHONY: build
build:
	docker build --build-arg VERSION=$(VERSION) -t $(IMAGE_NAME):$(IMAGE_TAG) -f $(ROOT_DIR)/Dockerfile $(ROOT_DIR)/src/

.PHONY: deploy
deploy:
	helm upgrade -i -f values.yaml $(APP_NAME) chart/
