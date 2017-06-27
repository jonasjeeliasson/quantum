#!/bin/sh

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
      certificate-authority-data:
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
      client-certificate-data:
      client-key-data:
EOF

kubectl config set clusters."${CLUSTER_NAME}".certificate-authority-data "${CERTIFICATE_AUTHORITY_DATA}"
kubectl config set users."${CLUSTER_NAME}"-admin.client-certificate-data "${CLIENT_CERTIFICATE_DATA}"
kubectl config set users."${CLUSTER_NAME}"-admin.client-key-data "${CLIENT_KEY_DATA}"