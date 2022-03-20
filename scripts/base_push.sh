#!/usr/bin/env bash

export DOCKER_ENV=base
SCRIPT_DIR=$(realpath $(dirname $0))
export BUILD_IMAGES=$BASE_IMAGES

$SCRIPT_DIR/build_push.sh "$@"
