echo "Installing Teamviewer"

sudo apt-get update && sudo apt-get upgrade

echo "Adding armhf architecture"
sudo dpkg --add-architecture armhf

sudo apt-get update && sudo apt-get upgrade
sudo apt-get -f install

sudo apt-get -y install libxtst6:armhf

echo "Downloading Teamviewer..."
wget https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb

echo "Running Installer..."
sudo dpkg -i teamviewer-host_armhf.deb

rm teamviewer-host_armhf.deb