#!/bin/bash

echo "Updating raspberrypi"

apt update && sudo apt upgrade -y

echo "Installing build-essential packages"
apt install -y build-essential

echo "Installing VLAN"
sh ./setup_vlan.sh

echo "Installing avahi-utils"
sudo apt-get install -y avahi-utils

