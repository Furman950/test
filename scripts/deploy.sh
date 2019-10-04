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
DOCKERFILE_LOCATION="./testWebAppReact/Dockerfile"

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

buildctl build --frontend dockerfile.v0 \
            --local dockerfile=. \
            --local context=. \
            --exporter image \
            --exporter-opt name=docker.io/furman9596/test:${TRAVIS_TAG}-amd64 \
            --exporter-opt push=true \
            --frontend-opt platform=linux/amd64 \
            --frontend-opt filename=./${DOCKERFILE_LOCATION}

buildctl build --frontend dockerfile.v0 \
            --local dockerfile=. \
            --local context=. \
            --exporter image \
            --exporter-opt name=docker.io/furman9596/test:${TRAVIS_TAG}-arm \
            --exporter-opt push=true \
            --frontend-opt platform=linux/armhf \
            --frontend-opt filename=./${DOCKERFILE_LOCATION}


export DOCKER_CLI_EXPERIMENTAL=enabled


docker manifest create furman9596/test:${TRAVIS_TAG} \
            furman9596/test:${TRAVIS_TAG}-amd64 \
            furman9596/test:${TRAVIS_TAG}-arm

docker manifest annotate furman9596/test:${TRAVIS_TAG} furman9596/test:${TRAVIS_TAG}-arm --arch arm
docker manifest annotate furman9596/test:${TRAVIS_TAG} furman9596/test:${TRAVIS_TAG}-amd64 --arch amd64

docker manifest push furman9596/test:${TRAVIS_TAG}
