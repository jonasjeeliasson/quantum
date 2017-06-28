#!/usr/bin/env bash

KEY=$1
BRANCH=$2

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

echo `printenv ${KEY}_${env}`
