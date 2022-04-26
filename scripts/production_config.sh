#!/usr/bin/env bash

export DOCKER_ENV=production
. $(realpath $(dirname $0))/base_env.sh

$DOCKER_COMPOSE config "$@"
