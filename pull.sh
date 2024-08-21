#!/bin/env bash
source $(dirname $0)/config.sh $1

$docker pull $docker_image
