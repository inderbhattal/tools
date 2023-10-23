sudo apt update && sudo apt upgrade -y

echo "Download RealVNC server"
wget https://downloads.realvnc.com/download/file/vnc.files/VNC-Server-6.9.1-Linux-ARM64.deb

echo "Installing RealVNC server"
sudo dpkg -i VNC-Server-6.9.1-Linux-ARM64.deb

cd /usr/lib/aarch64-linux-gnu

echo "Linking libs now!!!"
sudo ln libvcos.so /usr/lib/libvcos.so.0
sudo ln libvchiq_arm.so /usr/lib/libvchiq_arm.so.0
sudo ln libbcm_host.so /usr/lib/libbcm_host.so.0
sudo ln libmmal.so /usr/lib/libmmal.so.0
sudo ln libmmal_core.so /usr/lib/libmmal_core.so.0
sudo ln libmmal_components.so /usr/lib/libmmal_components.so.0
sudo ln libmmal_util.so /usr/lib/libmmal_util.so.0
sudo ln libmmal_vc_client.so /usr/lib/libmmal_vc_client.so.0
sudo ln libvcsm.so /usr/lib/libvcsm.so.0
sudo ln libcontainers.so /usr/lib/libcontainers.so.0