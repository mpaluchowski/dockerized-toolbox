#!/bin/bash

IMAGE_NAME=mpaluchowski/phpdox

docker rmi $IMAGE_NAME:latest

docker build -t $IMAGE_NAME .
