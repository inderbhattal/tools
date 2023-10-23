echo "Making Rust installation symlinks"


sudo ln -s /mnt/SSD-1/rust/cargo/ ~/.cargo
sudo ln -s /mnt/SSD-1/rust/rustup/ ~/.rustup

echo "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
