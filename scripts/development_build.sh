#!/usr/bin/env bash

export DOCKER_ENV=development
. $(realpath $(dirname $0))/base_env.sh

export PROGRESS_NO_TRUNC=1
time $DOCKER_COMPOSE build \
     --progress plain \
     --build-arg DOCKER_UID=$DOCKER_UID \
     --build-arg DOCKER_GID=$DOCKER_GID "$@"
