#!/usr/bin/env bash

export DOCKER_ENV=base
. $(realpath $(dirname $0))/base_env.sh

PROJECTS=$CLONE_PROJECTS
echo "CLONE PROJECTS: $PROJECTS"

echo "$PROJECTS" | tr ' ' '\n' | while read PROJECT; do
    PROJECT_DIR="${PROJECTS_DIR}/${PROJECT}"
    SERVICE_DIR="${ROOT_DIR}/${PROJECT}-service"

    if [[ ! -d $PROJECT_DIR ]]; then
        echo "CLONE: $PROJECT"
        PROJECT_URL="git@github.com:kikonen/${PROJECT}.git"
        $(cd $PROJECTS_DIR && git clone $PROJECT_URL)
    else
        echo "EXIST: $PROJECT"
    fi
done

bash -e $SCRIPT_DIR/setup_projects.sh "$@"
