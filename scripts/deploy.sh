#!/usr/bin/env bash

BRANCH=$1

if [ "${BRANCH}" == "master" ]; then
  env="STAGE"
elif [ "${BRANCH}" == "release" ]; then
  env="RELEASE"
else
  echo "Error: Branch not allowed:" ${BRANCH}
  exit -1
fi

docker_username=`printenv DOCKER_USERNAME_${env}`
docker_password=`printenv DOCKER_PASSWORD_${env}`
docker_registry=`printenv DOCKER_REGISTRY_${env}`

docker login -u=${docker_username} -p=${docker_password} ${docker_registry}
docker build -t "${docker_registry}/quantum" .
echo "deploying ${BRANCH} (Env -> ${env})"