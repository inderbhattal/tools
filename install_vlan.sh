#!/bin/bash

echo "Installing VLAN package"

sudo apt -y install vlan

echo "Installing kernel modules"
sudo apt -y install linux-modules-extra-raspi

sudo echo 8021q >> /etc/modules
