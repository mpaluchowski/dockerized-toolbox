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
	for image in ${IMAGES_TO_BUILD[@]}; do
		echo "Building $DOCKER_IMAGE_PREFIX/$image"
		docker build -t $DOCKER_IMAGE_PREFIX/$image $image
	done
}

runScript='#!/bin/bash

docker run \
	--rm \
	-v "/$(pwd):/app" \
__run_params__
	__image_name__:latest \
	$@
'

install-all() {
	for dir in `find -maxdepth 1 -type d -not -path . -not -path '*/\.*' -printf '%f\n'`
	do
		install-one $dir
	done
}

install-some() {
	for image in ${IMAGES_TO_BUILD[@]}; do
		install-one $image
	done
}

install-one() {
	toolName=$1
	imageName="$DOCKER_IMAGE_PREFIX/$toolName"
	echo "Installing running script for $imageName"

	runParams=''
	if [ -e $toolName/run-params.conf ]; then
		runParams=$(cat $toolName/run-params.conf | sed -e 's/^\(.*\)$/\t\1 \\/g')
		echo -e "\tAdding run parameters: $runParams"
	fi

	echo "$runScript" \
		| awk -v IMAGE_NAME="$imageName" -v RUN_PARAMS="$runParams" '{
			sub(/__image_name__/, IMAGE_NAME);
			sub(/__run_params__/, RUN_PARAMS);
			print;
		}' \
		| awk 'NF' \
		> ~/bin/$toolName
	echo "Created running script ~/bin/$toolName"
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
		if [ ${#IMAGES_TO_BUILD[@]} -gt 0 ]; then
			install-some
		else
			install-all
		fi
		;;
	*)
		echo "Usage $0 {build [tool-name tool-name]|install [-p|--prefix docker-image-prefix]}"
esac
