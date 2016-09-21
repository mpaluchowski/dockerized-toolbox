#!/bin/bash

# Default prefix is the current directory name
export DOCKER_IMAGE_PREFIX=${PWD##/*/}

while [[ $# -ge 1 ]]; do
    key="$1"
    case $key in
        -p|--prefix)
		# Custom prefix passed
        DOCKER_IMAGE_PREFIX=$2
        shift
        ;;
        *)
            # unknown option
        ;;
    esac
    shift
done

find -maxdepth 1 \
	-type d \
	-not -path . \
	-not -path '*/\.*' \
	-exec bash -c \
	'docker build -t $DOCKER_IMAGE_PREFIX/${1##.*/} $1' \
	-- {} \;
