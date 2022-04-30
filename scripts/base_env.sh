#!/usr/bin/env bash

if [[ $BASE_ENV_INCLUDED == 1 ]]; then
    #echo "$0 already included"
    return
fi
export BASE_ENV_INCLUDED=1

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

#echo "DOCKER_ENV=${DOCKER_ENV}"

if [[ $DOCKER_ENV == "" ]]; then
#    echo "DEFAULT: DOCKER_ENV=development"
    DOCKER_ENV=development
fi

if [[ $SERVICE_MODE == "" ]]; then
    SERVICE_MODE=server
fi

ENV_FILE="${ROOT_DIR}/.${DOCKER_ENV}_env"
if [[ -f $ENV_FILE ]]; then
   . $ENV_FILE
fi

DOCKER_COMPOSE_BASE="docker compose --project-directory=${ROOT_DIR} --project-name ${BASE_NAME}_${DOCKER_ENV} --env-file ${ENV_FILE}"

if [[ $DOCKER_ENV == 'production' ]]; then
    DOCKER_COMPOSE="${DOCKER_COMPOSE_BASE} -f docker-compose.yml -f docker-compose.${DOCKER_ENV}.yml"
elif [[ $DOCKER_ENV == 'base' ]]; then
    DOCKER_COMPOSE="${DOCKER_COMPOSE_BASE} -f docker-compose.yml -f docker-compose.${DOCKER_ENV}.yml"
elif [[ $DOCKER_ENV == 'build' ]]; then
    DOCKER_COMPOSE="${DOCKER_COMPOSE_BASE} -f docker-compose.yml -f docker-compose.${DOCKER_ENV}.yml"
else
    DOCKER_COMPOSE="${DOCKER_COMPOSE_BASE}"
fi

SECRETS_DIR="${ROOT_DIR}/.${DOCKER_ENV}_secrets"

COMPOSE_PROFILES=${DOCKER_ENV}

COMPOSE_DOCKER_CLI_BUILD=1
DOCKER_BUILDKIT=1

DOCKER_UID=$(id -u)
DOCKER_GID=$(id -g)

DOCKER_USER=$(id -un)
DOCKER_GROUP=$(id -gn)

echo "CMD: $DOCKER_COMPOSE"
echo "WEB: http://localhost:${NGINX_PORT}"

export ROOT_DIR
export SCRIPT_DIR
export PROJECTS_DIR
export BASE_NAME
export BUILD_TAG

export SECRETS_DIR

export COMPOSE_PROFILES
export COMPOSE_DOCKER_CLI_BUILD
export DOCKER_BUILDKIT

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
