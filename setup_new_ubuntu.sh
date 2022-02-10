echo "Now running setup scripts!"

echo "Running upgrade for all packages"
apt update && apt -y upgrade

echo "Installing build-essential packages"
apt install -y build-essential

echo "Installing gfw firewall"
sh ./install_firwall.sh

echo "Now Blacklisting Nouveau drivers"
sh ./blacklist_nouveau.sh

echo "Installing Atom Editor"
sh ./install_atom.sh

echo "Installing Chrome"
sh ./install_chrome.sh

echo "Installing Docker"
sh ./install_docker.sh

echo "Installing gnome-tweaks"
sh ./install_gnome_tweak_tool.sh

echo "Installing CUDA"
sh ./install_cuda.sh

echo "Installing Spotify"
sh ./install_spotify.sh


echo "Done with setup!"

sleep 5s

echo "Restarting in 3sec!"
sleep 3s
sudo reboot
