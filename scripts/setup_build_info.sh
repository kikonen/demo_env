#!/usr/bin/env bash

export DOCKER_ENV=build
. $(realpath $(dirname $0))/base_env.sh

PROJECTS=$(ls $PROJECTS_DIR)

# NOTE KI https://stackoverflow.com/questions/35385962/arrays-in-a-posix-compliant-shell
echo "$PROJECTS" | tr ' ' '\n' | while read PROJECT; do
    PROJECT_DIR=$PROJECTS_DIR/$PROJECT
    if [[ -d $PROJECT_DIR ]]; then
        echo "BUILD_INFO: $PROJECT_DIR"
        (cd $PROJECT_DIR && $SCRIPT_DIR/create_build_info.sh > $PROJECT_DIR/docker/build_info.json)
        cat $PROJECT_DIR/docker/build_info.json
    fi
done
