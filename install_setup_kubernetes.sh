#!/bin/sh

### Install kubernetes 
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

### Create config
mkdir ${HOME}/.kube
cat > ${HOME}/.kube/config << EOF
Hello on ${SOME_SECRET}!
EOF

