#!/usr/bin/env bash

. $(realpath $(dirname $0))/base_env.sh

$SCRIPT_DIR/container_shell.sh "$@"
