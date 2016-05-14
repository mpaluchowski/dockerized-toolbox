#!/bin/bash

docker run \
	--rm \
	-v $(pwd):/app \
	-v ~/.ssh:/root/.ssh \
	mpaluchowski/composer:latest \
	$@
