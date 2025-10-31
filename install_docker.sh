#!/bin/bash

sudo apt-get update

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

echo "Stopping docker service"
sudo systemctl stop docker

sleep 3s

sudo cp daemon.json /etc/docker

sleep 1s

sudo usermod -aG docker $USER

sleep 2s

newgrp docker

sleep 3s

sudo systemctl start docker