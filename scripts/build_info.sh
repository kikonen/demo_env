#!/usr/bin/env bash

resolve_cset() {
    CSET=`git log --format="%H" -n 1`
}

resolve_date() {
    DATE=`git log -n 1 --date=iso --pretty=format:"%ad"`
}

resolve_tag() {
    local tags=`git tag --points-at ${CSET}`
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
        local tmp_file=`mktemp /tmp/tags_XXXXX`
        echo "$tags" | tr ' ' '\n' | while read v; do
            if [[ ! "$v" =~ .*rc.* ]]; then
                echo $v >> $tmp_file
            fi
        done
        TAG=`sort $tmp_file | uniq | tr "\n" ' ' | cat | awk '{$1=$1;print}'`
        rm -f $tmp_file
    else
        TAG=$tags
    fi
}

resolve_rev() {
    local revs=`git log -1 --pretty=format:"%D" ${CSET}`
#    echo $revs

    local tmp_file=`mktemp /tmp/revs_XXXXX`
    local split_revs
    IFS=',' read -ra split_revs <<< "$revs"
    for v in "${split_revs[@]}"; do
        v=`echo $v | sed -e "s/ //g"`
        v=`echo $v | sed -e "s/HEAD->//g"`
        v=`echo $v | sed -e "s/tag:.*//g"`
        v=`echo $v | sed -e "s/origin\///g"`

        if [[ $v != "" ]]; then
#               echo "[$v]"
               echo $v >> $tmp_file
        fi
    done

    REV=`sort $tmp_file | uniq | tr "\n" ' ' | cat | awk '{$1=$1;print}'`

    rm -f $tmp_file
}

resolve_cset
resolve_date
resolve_tag
resolve_rev

#echo "[$CSET]"
#echo "[$DATE]"
#echo "[$TAG]"
#echo "[$REV]"

BUILD_DATE=$DATE
if [[ $TAG != "" ]]; then
    BUILD_REVISION=$TAG
else
    BUILD_REVISION=$REV
fi


printf "{\n\
  \"BUILD_DATE\": \"${BUILD_DATE}\",\n\
  \"BUILD_LABEL\": \"${BUILD_LABEL}\",\n\
  \"BUILD_REVISION\": \"${BUILD_REVISION}\"\n\
}\n"
exit

# NOTE KI assume extra tags are redundant rcX tags matching build tag
tags = tags_str.split(' ')
tags.delete_if { |t| /_rc/.match?(t) } if tags.size > 1
tags.delete_if { |t| /_alpha/.match?(t) } if tags.size > 1
tags_str = tags.join(' ') if tags.present?

tags_str



resolve_build_info() {
    build_date = find_date
    build_commit = find_commit

    build_tag = find_tag(build_commit)
    build_tag = find_name_rev(build_commit) if build_tag.blank?
    build_tag = nil if build_tag.blank?

    puts "DIR: #{Dir.getwd}"
    puts "DATE: #{build_date}"
    puts "COMMIT: #{build_commit}"
    puts "TAG: #{build_tag}"

    {
        date: build_date,
        rev: build_tag || build_commit,
    }
}

#   def self.info(working_dir)
#     bi = nil
#     Dir.chdir(working_dir) do
#       bi = resolve_build_info
#     end
#     "#{bi[:date]} - #{bi[:rev]}"
#   end
# end

# namespace :build do
#   desc 'Show build info'
#   task :show do
#     puts GenerateBuildInfo.info(Dir.getwd)
#   end

#   desc 'Save build info'
#   task :save, [:working_dir, :target_file]  do |t, args|
#     working_dir = args[:working_dir]
#     target_file = args[:target_file]

#     puts "SRC: #{working_dir}"
#     puts "DST: #{target_file}"

#     info = GenerateBuildInfo.info(working_dir)
#     File.open(target_file, "w" ) {|f| f.write "#{info}\n" }
#   end
# end
