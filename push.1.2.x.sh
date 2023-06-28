#!/bin/env bash
[ -z $1 ]&& (echo "Use $0 <last_number>" ; exit 1)
source $(dirname $0)/config.sh
IMAGE_TAG=1.2.$1
echo Push $docker_server/$docker_imagepath/$docker_imagename:$IMAGE_TAG ...
$docker push $docker_server/$docker_imagepath/$docker_imagename:$IMAGE_TAG
echo OK
