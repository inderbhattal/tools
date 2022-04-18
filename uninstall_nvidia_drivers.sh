echo "Uninstalling Nvidia Drivers!"

sudo service stop gdm3

sudo dpkg -P $(dpkg -l | grep nvidia-driver | awk '{print $2}')

sleep 3s

sudo apt autoremove
