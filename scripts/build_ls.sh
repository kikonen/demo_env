#!/usr/bin/env bash

. $(realpath $(dirname $0))/base_env.sh

BUILD_TAG=$1

if [[ $BUILD_TAG == "" ]]; then
    echo "USAGE: $0 [BUILD_TAG]"
    exit
fi

echo "IMAGES: $BUILD_IMAGES"

echo "$BUILD_IMAGES" | tr ' ' '\n' | while read IMAGE; do
    NAME=${BUILD_NAME}_${DOCKER_ENV}_${IMAGE}
    docker image ls | grep $NAME
done

#docker image ls | grep $BUILD_NAME
