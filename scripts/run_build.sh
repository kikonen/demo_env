DIR=`dirname $0`
DIR=`realpath $DIR`
ROOT_DIR=`dirname $DIR`

docker-compose --project-name build -f docker-compose.yml -f docker-compose.build.yml up "$@"
