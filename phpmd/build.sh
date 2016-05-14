#!/bin/bash

IMAGE_NAME=mpaluchowski/phpmd

docker rmi $IMAGE_NAME:latest

docker build -t $IMAGE_NAME .
