#!/bin/bash

echo "Now running setup scripts!"

echo "Running upgrade for all packages"
apt update && apt -y upgrade

echo "Installing build-essential packages"
apt install -y build-essential

echo "Installing gfw firewall"
sh ./install_firewall.sh

echo "Blacklisting Nouveau drivers"
sh ./blacklist_nouveau.sh

echo "Blacklisting kvm"
sh ./blacklist_kvm.sh

# echo "Installing Atom Editor"
# sh ./install_atom.sh

# echo "Installing Chrome"
# sh ./install_chrome.sh

# echo "Installing Brave browser"
# sh ./install_brave.sh

echo "Installing git"
sh ./install_git.sh

echo "Installing vscode"
sh ./install_vscode.sh

echo "Installing rust"
sh ./install_rust.sh

echo "Installing Nvidia support libs"
sh ./install_nvidia_drivers.sh

# echo "Installing Docker"
# sh ./install_docker.sh

echo "Installing gnome-tweaks"
sh ./install_gnome_tweak_tool.sh

# echo "Installing CUDA"
# sh ./install_cuda.sh

# echo "Installing Spotify"
# sh ./install_spotify.sh

echo "Updating Snap"
sh ./update_snap.sh

echo "Uninstalling snap firefox"
sh ./uninstall_snap_firefox.sh

echo "Setting up ssh keys"
sh ./setup_ssh.sh


echo "Done with setup!"

sleep 5s

echo "Restarting in 3sec!"
sleep 3s
# sudo reboot
