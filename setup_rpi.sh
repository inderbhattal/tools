#!/bin/bash

echo "Updating raspberrypi"

apt update && sudo apt upgrade -y

echo "Installing build-essential packages"
apt install -y build-essential