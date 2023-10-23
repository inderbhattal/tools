echo "Now running setup scripts!"

echo "Running upgrade for all packages"
apt update && apt -y upgrade

echo "Installing build-essential packages"
apt install -y build-essential

echo "Now Blacklisting Nouveau drivers"
sh ./blacklist_nouveau.sh

echo "Installing Docker"
sh ./install_docker.sh

echo "Installing CUDA"
sh ./install_cuda.sh

echo "Done with setup!"

sleep 5s

echo "Restarting in 3sec!"
sleep 3s
sudo reboot
