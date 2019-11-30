#!/usr/bin/env bash

echo "installing helpers..." 
apt-get update
apt-get install -y \
  shellinabox \
  jq

echo "installing docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update && apt-get install -y docker-ce
systemctl enable --now docker

echo "installing docker-compose..."
apt-get install -y docker-compose