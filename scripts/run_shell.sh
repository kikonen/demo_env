DIR=`dirname $0`
DIR=`realpath $DIR`
ROOT_DIR=`dirname $DIR`

CONTAINER=$1
SERVER_MODE=debug docker-compose up -d $CONTAINER

shift
docker-compose exec $CONTAINER bash "$@"
#docker-compose stop $CONTAINER
