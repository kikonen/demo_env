#!/usr/bin/env bash

export DOCKER_ENV=base
. $(realpath $(dirname $0))/base_env.sh

REPOSITORIES="host"
echo "REPOSITORIES: $REPOSITORIES"

echo "$REPOSITORIES" | tr ' ' '\n' | while read REPO; do
    REPO_DIR="${PROJECTS_DIR}/${REPO}"
    SERVICE_DIR="${ROOT_DIR}/${REPO}-service"

    if [[ ! -d $REPO_DIR ]]; then
        echo "CLONE: $REPO"
        REPO_URL="git@github.com:kikonen/${REPO}.git"
        $(cd $PROJECTS_DIR && git clone $REPO_URL)
    else
        echo "EXIST: $REPO"
    fi
done

bash -e $SCRIPT_DIR/setup_repositories.sh "$@"
