#!/bin/bash

IMAGE_NAME=mpaluchowski/pdepend

docker rmi $IMAGE_NAME:latest

docker build -t $IMAGE_NAME .
