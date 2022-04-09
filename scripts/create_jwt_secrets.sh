#!/usr/bin/env bash

if [[ $SCRIPT_DIR == "" ]]; then
    . $(realpath $(dirname $0))/base_env.sh
fi

#
# https://gist.github.com/ygotthilf/baa58da5c3dd1f69fae9
#

if [[ ! -d $SECRETS_DIR ]]; then
    echo "$SECRETS_DIR missing!"
    exit
fi

echo "NOTE: Don't add passphrase"
(cd $SECRETS_DIR && ssh-keygen -t rsa -b 4096 -m PEM -f jwt_key)
# Don't add passphrase
(cd $SECRETS_DIR && openssl rsa -in jwt_key -pubout -outform PEM -out jwt_key.pub)

ls -al $SECRETS_DIR
