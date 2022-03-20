#!/usr/bin/env bash

export DOCKER_ENV=base
SCRIPT_DIR=$(realpath $(dirname $0))

$SCRIPT_DIR/build_push "$@"
