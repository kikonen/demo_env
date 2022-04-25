#!/usr/bin/env bash

export DOCKER_ENV=build
. $(realpath $(dirname $0))/base_env.sh

PROJECTS=$(ls $PROJECTS_DIR)

# NOTE KI https://stackoverflow.com/questions/35385962/arrays-in-a-posix-compliant-shell
echo "$PROJECTS" | tr ' ' '\n' | while read PROJECT; do
    PROJECT_DIR=$PROJECTS_DIR/$PROJECT
    if [[ -d $PROJECT_DIR ]]; then
        echo "GIT_STATUS: $PROJECT_DIR"
        (cd $PROJECT_DIR && git citool "$@")
    fi
done
