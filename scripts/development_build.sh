#!/usr/bin/env bash

export DOCKER_ENV=development
. $(realpath $(dirname $0))/base_env.sh

time $DOCKER_COMPOSE build \
     --build-arg DOCKER_UID=$DOCKER_UID \
     --build-arg DOCKER_GID=$DOCKER_GID "$@"
