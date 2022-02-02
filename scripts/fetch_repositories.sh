DIR=`dirname $0`
DIR=`realpath $DIR`
ROOT_DIR=`dirname $DIR`

PROJECTS_DIR="$ROOT_DIR/projects"

REPOSITORIES=`ls $PROJECTS_DIR`
echo "REPOSITORIES: $REPOSITORIES"

echo "$REPOSITORIES" | tr ' ' '\n' | while read REPO; do
    REPO_DIR="$PROJECTS_DIR/${REPO}"
    SERVICE_DIR="$ROOT_DIR/${REPO}-service"

    if [[ -d $REPO_DIR ]]; then
        echo "FETCH: $REPO"
        $(cd $REPO_DIR && git fetch)
    fi
done

bash -e $DIR/setup_repositories.sh "$@"