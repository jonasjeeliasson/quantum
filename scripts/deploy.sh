#!/usr/bin/env bash

BRANCH=$1
VERSION=$2
BUILD_NUMBER=$3

case "${BRANCH}" in
  master)
    env="STAGE"
    ;;
  release)
    env="RELEASE"
    ;;
  *)
    echo "Error: Branch not allowed:" ${BRANCH}
    exit -1
    ;;
esac

docker_username=`printenv DOCKER_USERNAME_${env}`
docker_password=`printenv DOCKER_PASSWORD_${env}`
docker_registry=`printenv DOCKER_REGISTRY_${env}`

docker login -u=${docker_username} -p=${docker_password} ${docker_registry} && \
docker build -t ${docker_registry}:"quantum":${VERSION} . && \
docker push ${docker_registry}:"quantum":${VERSION} && \
kubectl set image deployment/quantum-deployment quantum=${docker_registry}:"quantum":${VERSION
