#!/usr/bin/env bash

. $(realpath $(dirname $0))/base_env.sh || exit

psql 127.0.0.1 "$@"
