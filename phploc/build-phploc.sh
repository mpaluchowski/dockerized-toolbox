#!/bin/bash

IMAGE_NAME=mpaluchowski/phploc

docker rmi $IMAGE_NAME:latest

docker build -t $IMAGE_NAME .
