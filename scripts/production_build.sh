#!/usr/bin/env bash

export DIR=`realpath \`dirname $0\``
export DOCKER_ENV=build
. $DIR/base_env.sh

$DIR/setup_build_info.sh

time $DOCKER_COMPOSE build "$@"
