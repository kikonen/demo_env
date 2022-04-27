#!/usr/bin/env bash

export DOCKER_ENV=build
. $(realpath $(dirname $0))/base_env.sh

$SCRIPT_DIR/setup_build_info.sh

VALUES=$(ls $SECRETS_DIR)
declare -a SECRET_KEYS=($VALUES)

for SECRET in "${SECRET_KEYS[@]}"; do
    VALUE=$(cat $SECRETS_DIR/$SECRET)

    KEY=SECRET_${SECRET}
    declare -g $KEY=${VALUE}
    export ${KEY}
done

export PROGRESS_NO_TRUNC=1
time $DOCKER_COMPOSE build \
     --progress plain \
     --build-arg HOST_MASTER_KEY=$SECRET_HOST_MASTER_KEY \
     --build-arg DOCKER_REGISTRY_URL=$DOCKER_REGISTRY_URL \
     --build-arg BUILD_NAME=$BUILD_NAME \
     --build-arg BASE_TAG=$BASE_TAG \
     --build-arg DOCKER_UID=$DOCKER_UID \
     --build-arg DOCKER_GID=$DOCKER_GID "$@"
