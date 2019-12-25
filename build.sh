#!/usr/bin/env bash

source ./config.sh

# Create output directory
mkdir -p $outputDir
mkdir -p $outputDir/posts

# Build CSS
cp -r css $outputDir/

function info() {
    unset title published renderTo
    render=no source $1
}

function renderName() {
    info $1
	[ "$renderTo" == "" ] && echo $(basename ${1%%.*}).html || echo "$renderTo".html
}

export -f info renderName

# Build pages
ls pages | while read fileName; do
    bash "pages/$fileName" > "site/$(renderName pages/$fileName)"
done

# Build posts
ls posts | while read fileName; do
	bash "posts/$fileName" > "site/posts/${fileName%%.*}.html"
done

