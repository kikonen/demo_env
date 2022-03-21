#!/usr/bin/env bash

DIR=`realpath \`dirname $0\``
ROOT_DIR=`dirname $DIR`
DOCKER_DIR=`realpath "$ROOT_DIR/.."`
CONTAINER=schema

$DOCKER_DIR/scripts/container_shell.sh $CONTAINER "$@"
