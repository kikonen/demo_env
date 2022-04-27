#!/usr/bin/env bash

export DOCKER_ENV=base
. $(realpath $(dirname $0))/base_env.sh

export PROGRESS_NO_TRUNC=1
time $DOCKER_COMPOSE build \
     --progress plain \
     "$@"
