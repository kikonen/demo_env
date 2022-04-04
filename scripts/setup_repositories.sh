#!/usr/bin/env bash

if [[ $SCRIPT_DIR == "" ]]; then
    . $(realpath $(dirname $0))/base_env.sh
fi

REPOSITORIES=$(ls $PROJECTS_DIR)
echo "SETUP REPOSITORIES: $REPOSITORIES"

echo "$REPOSITORIES" | tr ' ' '\n' | while read REPO; do
    REPO_DIR="${PROJECTS_DIR}/${REPO}"
    SERVICE_DIR="${ROOT_DIR}/${REPO}-service"

    if [[ ! -d $REPO_DIR ]]; then
        echo "N/A: $REPO_DIR"
    fi
#    echo $SERVICE_DIR

    cp -a $SERVICE_DIR/* $REPO_DIR
    cp -a $SERVICE_DIR/.dockerignore $REPO_DIR
    cp -a $SERVICE_DIR/.yarnrc $REPO_DIR
done

#ls -al $PROJECTS_DIR
