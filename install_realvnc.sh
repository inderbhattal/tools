sudo apt update && sudo apt upgrade -y

echo "Download RealVNC server"
wget https://downloads.realvnc.com/download/file/vnc.files/VNC-Server-6.9.1-Linux-ARM64.deb

echo "Installing RealVNC server"
sudo dpkg -i VNC-Server-6.9.1-Linux-ARM64.deb

echo "Linking libs now!!!"
sudo ln /usr/lib/aarch64-linux-gnu/libvcos.so /usr/lib/libvcos.so.0
sudo ln /usr/lib/aarch64-linux-gnu/libvchiq_arm.so /usr/lib/libvchiq_arm.so.0
sudo ln /usr/lib/aarch64-linux-gnu/libbcm_host.so /usr/lib/libbcm_host.so.0
sudo ln /usr/lib/aarch64-linux-gnu/libmmal.so /usr/lib/libmmal.so.0
sudo ln /usr/lib/aarch64-linux-gnu/libmmal_core.so /usr/lib/libmmal_core.so.0
sudo ln /usr/lib/aarch64-linux-gnu/libmmal_components.so /usr/lib/libmmal_components.so.0
sudo ln /usr/lib/aarch64-linux-gnu/libmmal_util.so /usr/lib/libmmal_util.so.0
sudo ln /usr/lib/aarch64-linux-gnu/libmmal_vc_client.so /usr/lib/libmmal_vc_client.so.0
sudo ln /usr/lib/aarch64-linux-gnu/libvcsm.so /usr/lib/libvcsm.so.0
sudo ln /usr/lib/aarch64-linux-gnu/libcontainers.so /usr/lib/libcontainers.so.0

echo "Removing installer!"
rm VNC-Server-6.9.1-Linux-ARM64.deb

sudo systemctl enable vncserver-virtuald.service
sudo systemctl enable vncserver-x11-serviced.service
sudo systemctl start vncserver-virtuald.service
sudo systemctl start vncserver-x11-serviced.service