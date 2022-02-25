#!/usr/bin/env bash

export DOCKER_ENV=base
. $(realpath $(dirname $0))/base_env.sh

time $DOCKER_COMPOSE build "$@"
