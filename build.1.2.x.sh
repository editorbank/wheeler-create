#!/bin/env bash
[ -z $1 ]&& (echo "Use $0 <last_number>" ; exit 1)
source $(dirname $0)/config.sh
IMAGE_TAG=1.2.$1
$docker build . -f $IMAGE_TAG.Dockerfile -t $docker_server/$docker_imagepath/$docker_imagename:$IMAGE_TAG &&\
$docker save -o wheeler-$IMAGE_TAG.docker.img docker.io/editorbank/wheeler:$IMAGE_TAG &&\
echo OK
