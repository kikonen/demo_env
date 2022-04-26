#!/usr/bin/env bash

export DOCKER_ENV=development
. $(realpath $(dirname $0))/base_env.sh

$DOCKER_COMPOSE config "$@"
