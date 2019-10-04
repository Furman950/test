#!/bin/bash
echo "Running deploy script"
set -ev
if [ $# -ne 3 ]
then
    echo "Invalid number of arguments passed, required 3, found $#"
    exit 1
fi

TAG=$1
DOCKER_USERNAME=$2
DOCKER_PASSWORD=$3

echo "TAG: $TAG"
docker build -f ./testWebAppReact/Dockerfile -t "furman9596/test:$TAG" .
echo "$DOCKER_PASSWORD"
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push furman9596/test:$TAG
