#!/bin/bash

echo "Setting up ssh folder"
rm -rf "/home/inder/.ssh"

ln -s "/mnt/Data/Inder/Important Stuff/ssh_keys/.ssh" "/home/inder/.ssh"