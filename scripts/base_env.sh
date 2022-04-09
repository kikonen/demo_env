#!/usr/bin/env bash

SCRIPT_DIR=$(realpath $(dirname $0))
ROOT_DIR=$(dirname $SCRIPT_DIR)
if [[ -f $ROOT_DIR/.env ]]; then
   . $ROOT_DIR/.env
fi
PROJECTS_DIR=$ROOT_DIR/projects

if [[ $BASE_NAME == "" ]]; then
    echo "BASE_NAME missing from .env"
    exit
fi

echo "DOCKER_ENV=${DOCKER_ENV}"

if [[ $DOCKER_ENV == "" ]]; then
    echo "DEFAULT: DOCKER_ENV=development"
    DOCKER_ENV=development
fi

if [[ $SERVICE_MODE == "" ]]; then
    SERVICE_MODE=server
fi


DOCKER_COMPOSE_BASE="docker-compose --project-dir=${ROOT_DIR} --project-name ${BASE_NAME}_${DOCKER_ENV} --env-file ${ROOT_DIR}/.${DOCKER_ENV}_env"

if [[ $DOCKER_ENV == 'production' ]]; then
    DOCKER_COMPOSE="${DOCKER_COMPOSE_BASE} -f docker-compose.yml -f docker-compose.${DOCKER_ENV}.yml"
elif [[ $DOCKER_ENV == 'base' ]]; then
    DOCKER_COMPOSE="${DOCKER_COMPOSE_BASE} -f docker-compose.yml -f docker-compose.${DOCKER_ENV}.yml"
elif [[ $DOCKER_ENV == 'build' ]]; then
    DOCKER_COMPOSE="${DOCKER_COMPOSE_BASE} -f docker-compose.yml -f docker-compose.${DOCKER_ENV}.yml"
else
    DOCKER_COMPOSE="${DOCKER_COMPOSE_BASE}"
fi

COMPOSE_PROFILES=${DOCKER_ENV}

DOCKER_UID=$(id -u)
DOCKER_GID=$(id -g)

DOCKER_USER=$(id -un)
DOCKER_GROUP=$(id -gn)

echo "CMD=$DOCKER_COMPOSE"

export ROOT_DIR
export SCRIPT_DIR
export PROJECTS_DIR
export BASE_NAME
export BUILD_TAG
export COMPOSE_PROFILES

export CLONE_PROJECTS
export BUILD_NAME
export BUILD_IMAGES
export DOCKER_ENV
export DOCKER_REGISTRY_URL

export SERVICE_MODE

export DOCKER_UID
export DOCKER_GID

export DOCKER_USER
export DOCKER_GROUP

$SCRIPT_DIR/setup_projects.sh
