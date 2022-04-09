#!/usr/bin/env bash

. $(realpath $(dirname $0))/base_env.sh

PROJECTS=$(ls $PROJECTS_DIR)
echo "FETCH PROJECTS: $PROJECTS"

echo "$PROJECTS" | tr ' ' '\n' | while read PROJECT; do
    PROJECT_DIR="$PROJECTS_DIR/${PROJECT}"
    SERVICE_DIR="$ROOT_DIR/${PROJECT}-service"

    if [[ -d $PROJECT_DIR ]]; then
        echo "FETCH: $PROJECT"
        $(cd $PROJECT_DIR && git fetch)
    fi
done

bash -e $SCRIPT_DIR/setup_projects.sh "$@"
