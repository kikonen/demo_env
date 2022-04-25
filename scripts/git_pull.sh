#!/usr/bin/env bash

. $(realpath $(dirname $0))/base_env.sh

PROJECTS=$(ls $PROJECTS_DIR)
echo "PULL PROJECTS: $PROJECTS"

echo "$PROJECTS" | tr ' ' '\n' | while read PROJECT; do
    PROJECT_DIR="$PROJECTS_DIR/${PROJECT}"
    SERVICE_DIR="$ROOT_DIR/${PROJECT}-service"

    if [[ -d $PROJECT_DIR ]]; then
        BRANCH=$(cd $PROJECT_DIR && git rev-parse --abbrev-ref HEAD)

        echo "----------------------------------------"
        echo "PULL: $PROJECT (BRANCH: $BRANCH)"

        (cd $PROJECT_DIR && git fetch && git pull "$@")
        (cd $PROJECT_DIR && git --no-pager log -2)
    fi
done

bash -e $SCRIPT_DIR/setup_projects.sh
