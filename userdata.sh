#!/bin/bash
set -e

apt-get update -y
apt-get install -y docker.io curl

systemctl enable docker
systemctl start docker

# kubectl
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Kind
curl -Lo /usr/local/bin/kind \
https://kind.sigs.k8s.io/dl/v0.30.0/kind-linux-amd64
chmod +x /usr/local/bin/kind

# Docker permission
usermod -aG docker ubuntu
