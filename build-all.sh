#!/bin/bash

find -maxdepth 1 \
	-type d \
	-not -path . \
	-not -path '*/\.*' \
	-exec bash -c \
	'cd $1; bash build.sh' \
	-- {} \;
