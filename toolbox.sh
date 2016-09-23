#!/bin/bash

# Default prefix is the current directory name
export DOCKER_IMAGE_PREFIX=${PWD##/*/}

COMMAND=$1
shift

IMAGES_TO_BUILD=()

while [[ $# -ge 1 ]]; do
    key="$1"
    case $key in
        -p|--prefix)
		# Custom prefix passed
        DOCKER_IMAGE_PREFIX=$2
        shift
        ;;
        *)
        # Name of container to build
        IMAGES_TO_BUILD=(${IMAGES_TO_BUILD[@]} ${1%/})
        ;;
    esac
    shift
done

build-all() {
	echo "Building all images"
	find -maxdepth 1 \
		-type d \
		-not -path . \
		-not -path '*/\.*' \
		-exec bash -c \
		'docker build -t $DOCKER_IMAGE_PREFIX/${1##.*/} $1' \
		-- {} \;
}

build-some() {
	for container in ${IMAGES_TO_BUILD[@]}; do
		echo "Building $DOCKER_IMAGE_PREFIX/$container"
		docker build -t $DOCKER_IMAGE_PREFIX/$container $container
	done
}

install-all() {
	for dir in `find -maxdepth 1 -type d -not -path . -not -path '*/\.*' -printf '%f\n'`
	do
		cp ./$dir/run.sh ~/bin/$dir
		echo "Copied ./$dir/run.sh to ~/bin/$dir"
	done
}


case "$COMMAND" in
	build)
		if [ ${#IMAGES_TO_BUILD[@]} -gt 0 ]; then
			build-some
		else
			build-all
		fi
		;;
	install)
		install-all
		;;
	*)
		echo "Usage $0 {build [tool-name tool-name]|install [-p|--prefix docker-image-prefix]}"
esac
