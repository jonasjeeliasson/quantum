#!/usr/bin/env bash

BRANCH=$1

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

docker login -u=${docker_username} -p=${docker_password} ${docker_registry}
docker build -t "${docker_registry}/quantum" .
kubectl get nodes
echo "deploying ${BRANCH} (Env -> ${env})"
