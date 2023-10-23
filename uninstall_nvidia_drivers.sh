#!/bin/bash

echo "Uninstalling Nvidia Drivers!"

sudo service gdm3 stop

sudo dpkg -P $(dpkg -l | grep nvidia-driver | awk '{print $2}')

sleep 3s

sudo apt autoremove
