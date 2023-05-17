#!/bin/env bash
source $(dirname $0)/config.sh $1

if [ ! -z "$($docker images --filter=reference=$docker_image -q)" ] ;then
  $docker login $docker_server && $docker push $docker_image
fi
