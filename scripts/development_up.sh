#!/usr/bin/env bash

export DOCKER_ENV=development
. $(realpath $(dirname $0))/base_env.sh || exit

$DOCKER_COMPOSE up "$@"
