#!/usr/bin/env bash

resolve_cset() {
    CSET=$(git log --format="%H" -n 1)
}

resolve_date() {
    DATE=$(git log -n 1 --date=iso --pretty=format:"%ad")
}

resolve_tag() {
    local tags=$(git tag --points-at ${CSET})
#    echo $tags

    local has_release
    local has_rc

    echo "$tags" | tr ' ' '\n' | while read v; do
        if [[ "$v" =~ .*rc.* ]]; then
            exit 42
        fi
    done
    if [[ $? == "42" ]]; then
        has_rc=1
    fi

    echo "$tags" | tr ' ' '\n' | while read v; do
        if [[ ! "$v" =~ .*rc.* ]]; then
            exit 42
        fi
    done
    if [[ $? == "42" ]]; then
        has_release=1
    fi

    if [[ $has_release == 1 && $has_rc == 1 ]]; then
        local tmp_file=$(mktemp /tmp/tags_XXXXX)
        echo "$tags" | tr ' ' '\n' | while read v; do
            if [[ ! "$v" =~ .*rc.* ]]; then
                echo $v >> $tmp_file
            fi
        done
        TAG=$(sort $tmp_file | uniq | tr "\n" ' ' | cat | awk '{$1=$1;print}')
        rm -f $tmp_file
    else
        TAG=$tags
    fi
}

resolve_branch() {
    local branches=$(git log -1 --pretty=format:"%D" ${CSET})
#    echo $branches

    local tmp_file=$(mktemp /tmp/branches_XXXXX)
    local split_branches
    IFS=',' read -ra split_branches <<< "$branches"
    for v in "${split_branches[@]}"; do
        v=$(echo $v | sed -e "s/ //g")
        v=$(echo $v | sed -e "s/HEAD->//g")
        v=$(echo $v | sed -e "s/tag:.*//g")
        v=$(echo $v | sed -e "s/origin\///g")

        if [[ $v != "" ]]; then
#               echo "[$v]"
               echo $v >> $tmp_file
        fi
    done

    BRANCH=$(sort $tmp_file | uniq | tr "\n" ' ' | cat | awk '{$1=$1;print}')

    rm -f $tmp_file
}

resolve_cset
resolve_date
resolve_tag
resolve_branch

#echo "[$CSET]"
#echo "[$DATE]"
#echo "[$TAG]"
#echo "[$BRANCH]"

BUILD_DATE_VALUE="\"$DATE\""
BUILD_CSET_VALUE="\"$CSET\""
BUILD_BRANCH_VALUE="\"$BRANCH\""

if [[ $TAG != "" ]]; then
    BUILD_TAG_VALUE="\"$TAG\""
else
    BUILD_TAG_VALUE="null";
fi

printf "{\n\
  \"build_date\": ${BUILD_DATE_VALUE},\n\
  \"build_cset\": ${BUILD_CSET_VALUE},\n\
  \"build_tag\": ${BUILD_TAG_VALUE},\n\
  \"build_branch\": ${BUILD_BRANCH_VALUE}\n\
}\n"
