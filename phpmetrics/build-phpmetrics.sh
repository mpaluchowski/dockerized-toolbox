#!/bin/bash

IMAGE_NAME=mpaluchowski/phpmetrics

docker rmi $IMAGE_NAME:latest

docker build -t $IMAGE_NAME .
