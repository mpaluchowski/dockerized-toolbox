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

runScript='#!/bin/bash

docker run \
	--rm \
	-v $(pwd):/app \
__run_params__
	__image_name__:latest \
	$@
'

install-all() {
	for dir in `find -maxdepth 1 -type d -not -path . -not -path '*/\.*' -printf '%f\n'`
	do
		imageName="$DOCKER_IMAGE_PREFIX/$dir"

		runParams=''
		if [ -e $dir/run-params.conf ]; then
			runParams=$(cat $dir/run-params.conf | sed -e 's/^\(.*\)$/\t\1 \\/g')
			echo -e "\tAdding run parameters: $runParams"
		fi

		echo "$runScript" \
			| awk -v IMAGE_NAME="$imageName" -v RUN_PARAMS="$runParams" '{
				sub(/__image_name__/, IMAGE_NAME);
				sub(/__run_params__/, RUN_PARAMS);
				print;
			}' \
			| awk 'NF' \
			> ~/bin/$dir
		echo "Created running script ~/bin/$dir"
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
