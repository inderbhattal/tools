touch /etc/modprobe.d/blacklist-nouveau.conf

echo "blacklist nouveau" >> /etc/modprobe.d/blacklist-nouveau.conf
echo "options nouveau modeset=0" >> /etc/modprobe.d/blacklist-nouveau.conf

echo "Blacklisted Nouveau drivers"

echo "Regenerate the kernel initramfs"
update-initramfs -u
