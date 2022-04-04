#!/usr/bin/env bash

if [[ $SCRIPT_DIR == "" ]]; then
    . $(realpath $(dirname $0))/base_env.sh
fi

REPOSITORIES=$(ls $PROJECTS_DIR)
echo "SETUP REPOSITORIES: $REPOSITORIES"

LOGS_DIR=$ROOT_DIR/log

echo "$REPOSITORIES" | tr ' ' '\n' | while read REPO; do
    if [[ $REPO == "" ]]; then
        continue
    fi

    REPO_DIR="${PROJECTS_DIR}/${REPO}"
    SERVICE_DIR="${ROOT_DIR}/${REPO}-service"

    if [[ ! -d $REPO_DIR ]]; then
        echo "N/A: $REPO_DIR"
        continue
    fi
#    echo $SERVICE_DIR

    cp -a $SERVICE_DIR/* $REPO_DIR
    cp -a $SERVICE_DIR/.dockerignore $REPO_DIR
    cp -a $SERVICE_DIR/.yarnrc $REPO_DIR

    (cd $LOGS_DIR && rm $REPO && ln -s $REPO_DIR/log $REPO)
done

#ls -al $PROJECTS_DIR
