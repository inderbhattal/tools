#!/bin/bash

echo "Downloading chrome..."

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

echo "Installing chrome..."
sudo dpkg -i google-chrome-stable_current_amd64.deb

echo "Deleting installer..."
rm google-chrome-stable_current_amd64.deb
