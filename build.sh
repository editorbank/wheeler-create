#!/bin/env bash
source $(dirname $0)/config.sh $1

if [ -z "$($docker images --filter=reference=$docker_image -q)" ] ;then
  find ./.downloaded -exec basename {} \;|sort                   |grep -v .txt|grep -v .zip>.downloaded/index.txt
  find ./.downloaded -exec basename {} \;|sort|grep -v win_amd64 |grep -v .txt|grep -v .zip>.downloaded/linux.txt
  find ./.downloaded -exec basename {} \;|sort|grep -v .manylinux|grep -v .txt|grep -v .zip>.downloaded/windows.txt
  $docker build . -t $docker_image
else
  echo Image $docker_image already builded!
fi
