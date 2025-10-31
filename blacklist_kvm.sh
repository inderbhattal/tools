#!/bin/bash

touch /etc/modprobe.d/blacklist-kvm.conf

echo "blacklist kvm_amd" >> /etc/modprobe.d/blacklist-kvm.conf
echo "blacklist kvm" >> /etc/modprobe.d/blacklist-kvm.conf

echo "Blacklisted kvm"

echo "Regenerate the kernel initramfs"
sudo update-initramfs -u
