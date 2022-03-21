#!/usr/bin/env bash

. $(realpath $(dirname $0))/base_env.sh || exit

psql -h 127.0.0.1 -U postgres "$@"
