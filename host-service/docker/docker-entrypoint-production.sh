#!/bin/bash

if [[ $1 != '' ]]; then
    exec "$@"
    exit $?
fi

echo "SERVICE_MODE: $SERVICE_MODE"

if [[ "$SERVICE_MODE" == "debug" ]]; then
    sleep infinity
else
    bundle exec rails s -b 0.0.0.0 -p 3000
fi
