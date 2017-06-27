#!/bin/sh

cluster_srv=`printenv DOCKER_USERNAME_$1`
echo $cluster_srv | rev

docker login -u=${DOCKER_USERNAME} -p=${DOCKER_PASSWORD} ${DOCKER_REGISTRY}
docker build -t "${DOCKER_REGISTRY}/quantum" .
echo "deploying $TRAVIS_BRANCH (Pull request -> $TRAVIS_PULL_REQUEST)"