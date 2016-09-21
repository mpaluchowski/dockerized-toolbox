#!/bin/bash

export DOCKER_IMAGE_PREFIX=mpaluchowski

find -maxdepth 1 \
	-type d \
	-not -path . \
	-not -path '*/\.*' \
	-exec bash -c \
	'docker build -t $DOCKER_IMAGE_PREFIX/${1##.*/} $1' \
	-- {} \;
