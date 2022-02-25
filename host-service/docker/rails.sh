#!/usr/bin/env bash

SCRIPT_DIR=$(realpath $(dirname $0))/../../../scripts
CONTAINER=host

$SCRIPT_DIR/rails_run.sh $CONTAINER "$@"
