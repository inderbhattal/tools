#!/bin/bash

echo "Making Rust installation symlinks"

sudo ln -sf /mnt/SSD-1/rust/cargo/ /home/inder/.cargo
sudo ln -sf /mnt/SSD-1/rust/rustup/ /home/inder/.rustup

echo "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
