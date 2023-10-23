#!/bin/bash

echo "Running upgrade for all packages"
sudo apt update && sudo apt -y upgrade

sudo apt -y install software-properties-common apt-transport-https wget

wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" -y

sudo apt -y install atom
