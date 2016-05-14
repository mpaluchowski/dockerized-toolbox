#!/bin/bash

docker run \
	--rm \
	-v $(pwd):/app \
	mpaluchowski/phpmd:latest \
	$@
