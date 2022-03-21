#!/usr/bin/env bash

. $(realpath $(dirname $0))/base_env.sh

CONTAINER=$1
SERVICE_MODE=debug $DOCKER_COMPOSE up -d $CONTAINER

shift
$DOCKER_COMPOSE exec $CONTAINER "$@"
