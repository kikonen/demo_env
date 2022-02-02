DIR=`dirname $0`
DIR=`realpath $DIR`
ROOT_DIR=`dirname $DIR`

CONTAINER=$1
SERVER_MODE=debug docker-compose --project-dir=$ROOT_DIR up -d $CONTAINER

shift
docker-compose --project-dir=$ROOT_DIR exec $CONTAINER bash "$@"
#docker-compose --project-dir=$ROOT_DIR stop $CONTAINER
