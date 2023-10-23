#!/bin/bash

echo "Making vscode symlinks"
sudo ln -s /mnt/SSD-1/vscode/.vscode/ /home/inder/.vscode

echo "Getting vscode deb install file"
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O code.deb

echo "Installing VSCode"
sudo dpkg -i code.deb

sudo rm code.deb