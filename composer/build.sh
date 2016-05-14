#!/bin/bash

IMAGE_NAME=mpaluchowski/composer

docker rmi $IMAGE_NAME:latest

docker build -t $IMAGE_NAME .
