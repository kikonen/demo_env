#!/usr/bin/env bash

export DOCKER_ENV=build
. $(realpath $(dirname $0))/base_env.sh

$SCRIPT_DIR/setup_build_info.sh

time $DOCKER_COMPOSE build "$@"
