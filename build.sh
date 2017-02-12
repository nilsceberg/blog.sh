#!/usr/bin/env bash

source ./config.sh

# Create output directory
mkdir -p $outputDir

# Build CSS
cp -r css $outputDir/

# Build pages
ls pages | while read fileName; do
	bash "pages/$fileName" > "site/${fileName%%.*}.html"
done

# Build posts
ls posts | while read fileName; do
	bash "posts/$fileName" > "site/posts/${fileName%%.*}.html"
done

