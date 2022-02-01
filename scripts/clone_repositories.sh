DIR=`dirname $0`
DIR=`realpath $DIR`
ROOT_DIR=`dirname $DIR`

REPOSITORIES="host"

PROJECTS_DIR="$ROOT_DIR/projects"
cd $PROJECTS_DIR

echo "$REPOSITORIES" | tr ' ' '\n' | while read REPO; do
    if [[ -d $$REPO ]]; then
        echo "EXIST: $REPO"
        continue
    fi

    echo "CLONE: $REPO"
    REPO_URL="git@github.com:kikonen/${REPO}.git"
    git clone $REPO_URL
done

ls -al $PROJECTS_DIR
