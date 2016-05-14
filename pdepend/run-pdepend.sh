#!/bin/bash

docker run \
	--rm \
	-v $(pwd):/app \
	mpaluchowski/pdepend:latest \
	$@
