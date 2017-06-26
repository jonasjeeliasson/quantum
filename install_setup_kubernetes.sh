#!/bin/sh

TEST=$1
echo $TEST

### Install kubernetes 
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

### Create config
mkdir ${HOME}/.kube
cat > ${HOME}/.kube/config << EOF
---
apiVersion: v1
clusters:
  - cluster:
      certificate-authority-data: ${CERTIFICATE_AUTHORITY_DATA}
      server: ${CLUSTER_SERVER}
    name: "${CLUSTER_NAME}"
contexts:
  - context:
      cluster: "${CLUSTER_NAME}"
      user: "${CLUSTER_NAME}-admin"
    name: "${CLUSTER_NAME}"
current-context: "${CLUSTER_NAME}"
kind: Config
users:
  - name: "${CLUSTER_NAME}-admin"
    user:
      client-certificate-data: ${CLIENT_CERTIFICATE_DATA}
      client-key-data: ${CLIENT_KEY_DATA}
EOF

