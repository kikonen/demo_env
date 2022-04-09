#!/usr/bin/env bash

if [[ $SCRIPT_DIR == "" ]]; then
    . $(realpath $(dirname $0))/base_env.sh
fi

PROJECTS=$(ls $PROJECTS_DIR)
echo "SETUP PROJECTS: $PROJECTS"

LOGS_DIR=$ROOT_DIR/log

echo "$PROJECTS" | tr ' ' '\n' | while read PROJECT; do
    if [[ $PROJECT == "" ]]; then
        continue
    fi

    PROJECT_DIR="${PROJECTS_DIR}/${PROJECT}"
    SERVICE_DIR="${ROOT_DIR}/${PROJECT}-service"

    if [[ ! -d $PROJECT_DIR ]]; then
        echo "N/A: $PROJECT_DIR"
        continue
    fi
#    echo $SERVICE_DIR

    cp -a $SERVICE_DIR/* $PROJECT_DIR
    cp -a $SERVICE_DIR/.dockerignore $PROJECT_DIR
    cp -a $SERVICE_DIR/.yarnrc $PROJECT_DIR

    (cd $LOGS_DIR && rm -f $PROJECT && ln -s $PROJECT_DIR/log $PROJECT)
done

#ls -al $PROJECTS_DIR
