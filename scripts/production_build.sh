#!/usr/bin/env bash

export DOCKER_ENV=build
. $(realpath $(dirname $0))/base_env.sh

$SCRIPT_DIR/setup_build_info.sh

time $DOCKER_COMPOSE build \
     --build-arg DOCKER_REGISTRY_URL=$DOCKER_REGISTRY_URL \
     --build-arg BUILD_NAME=$BUILD_NAME \
     --build-arg BASE_TAG=$BASE_TAG \
     --build-arg DOCKER_UID=$DOCKER_UID \
     --build-arg DOCKER_GID=$DOCKER_GID "$@"
