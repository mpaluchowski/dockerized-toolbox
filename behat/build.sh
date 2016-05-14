#!/bin/bash

IMAGE_NAME=mpaluchowski/behat

docker rmi $IMAGE_NAME:latest

docker build -t $IMAGE_NAME .
