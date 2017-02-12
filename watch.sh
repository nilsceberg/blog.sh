#!/usr/bin/env bash

source ./build.sh

pushd $outputDir
python3 -m http.server 8080 &
trap "kill $!" EXIT
popd

watch ./build.sh

