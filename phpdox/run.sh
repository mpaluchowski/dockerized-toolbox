#!/bin/bash

docker run \
	--rm \
	-v $(pwd):/app \
	mpaluchowski/phpdox:latest \
	$@
