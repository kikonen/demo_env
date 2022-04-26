#!/usr/bin/env bash

export DOCKER_ENV=build
. $(realpath $(dirname $0))/base_env.sh

$DOCKER_COMPOSE config "$@"
