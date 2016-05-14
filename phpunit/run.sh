#!/bin/bash

docker run \
	--rm \
	-v $(pwd):/app \
	mpaluchowski/phpunit:latest \
	$@
