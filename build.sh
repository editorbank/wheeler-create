#!/bin/env bash
source $(dirname $0)/config.sh $1

if [ -z "$($docker images --filter=reference=$docker_image -q)" ] ;then
  ./make_index_html.sh
  echo $docker build . -t $docker_image --build-arg DEFAULT_WHEELER_PORT=8080
  $docker build . -t $docker_image --build-arg DEFAULT_WHEELER_PORT=8080
else
  echo Image $docker_image already builded!
fi
