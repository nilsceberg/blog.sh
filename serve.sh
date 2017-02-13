#!/usr/bin/env bash

source ./build.sh

if [ "$1" == "-w" ]; then
	pushd $outputDir
	python3 -m http.server 8080 &
	trap "kill $!" EXIT
	popd

	watch ./build.sh
else
	cd $outputDir
	python3 -m http.server 8080
fi

