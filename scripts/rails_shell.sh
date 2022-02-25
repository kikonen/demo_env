#!/usr/bin/env bash

. $(realpath $(dirname $0))/base_env.sh

CONTAINER=$1
SERVER_MODE=debug $DOCKER_COMPOSE up -d $CONTAINER

shift
$DOCKER_COMPOSE exec $CONTAINER bash "$@"
#$DOCKER_COMPOSE stop $CONTAINER
