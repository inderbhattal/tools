#!/bin/sh

echo "Setting up VLAN's"

sudo ip link add eth0.30 link eth0 type vlan id 30
sudo dhclient eth0.30
sudo ip link set dev eth0.30 up

sudo ip link add eth0.32 link eth0 type vlan id 32
sudo dhclient eth0.32
sudo ip link set dev eth0.32 up

sudo ip link add eth0.39 link eth0 type vlan id 39
sudo dhclient eth0.39
sudo ip link set dev eth0.39 up

sudo ip link add eth0.40 link eth0 type vlan id 40
sudo dhclient eth0.40
sudo ip link set dev eth0.40 up

echo "Restarting avahi"
sudo service avahi-daemon restart
