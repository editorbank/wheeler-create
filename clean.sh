#!/bin/env bash
source $(dirname $0)/config.sh $1

if [ ! -z "$($docker images --filter=reference=$docker_image -q)" ] ;then
  $docker rmi -f $docker_image
fi

[ -d .venv ] && rm -r .venv
[ -d .python-embed ] && rm -r .python-embed

for i in $(git ls-files --others --ignored --exclude-standard|grep -v .downloaded); do
  rm $i
done

