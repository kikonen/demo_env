#!/usr/bin/env bash

export DOCKER_ENV=build
SCRIPT_DIR=$(realpath $(dirname $0))

$SCRIPT_DIR/build_push.sh "$@"
