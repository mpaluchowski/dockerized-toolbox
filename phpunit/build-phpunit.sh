#!/bin/bash

IMAGE_NAME=mpaluchowski/phpunit

docker rmi $IMAGE_NAME:latest

docker build -t $IMAGE_NAME .
