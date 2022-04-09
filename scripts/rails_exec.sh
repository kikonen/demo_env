#!/usr/bin/env bash

. $(realpath $(dirname $0))/base_env.sh

CONTAINER=$1

if [[ $CONTAINER == "" ]]; then
    echo "USAGE: $0 [CONTAINER]"
    exit
fi

SERVICE_MODE=debug $DOCKER_COMPOSE up -d $CONTAINER

shift
#$DOCKER_COMPOSE exec $CONTAINER bash -c "bundle check || bundle install"
#$DOCKER_COMPOSE exec $CONTAINER bash -c "yarn install"
$DOCKER_COMPOSE exec $CONTAINER "$@"
