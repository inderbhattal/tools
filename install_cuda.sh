echo "Downloading CUDA"
wget https://developer.download.nvidia.com/compute/cuda/11.6.0/local_installers/cuda_11.6.0_510.39.01_linux.run

echo "Installing CUDA"
sudo sh cuda_11.6.0_510.39.01_linux.run --silent

echo "Setting CUDA path variables"

echo "export CUDA_HOME=\"/usr/local/cuda-11.6/bin\"" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\"/usr/local/cuda-11.6/lib64:$LD_LIBRARY_PATH\""  >> ~/.bashrc
echo "export PATH=\"$CUDA_HOME:$PATH"\" >> ~/.bashrc
