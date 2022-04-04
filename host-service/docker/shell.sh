#!/usr/bin/env bash

SCRIPT_DIR=$(realpath $(dirname $0)/../../../scripts)
CONTAINER=host

$SCRIPT_DIR/container_shell.sh $CONTAINER "$@"
