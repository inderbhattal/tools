#!/bin/bash

echo "Downloading CUDA"
wget https://developer.download.nvidia.com/compute/cuda/11.6.2/local_installers/cuda_11.6.2_510.47.03_linux.run

# echo "Installing CUDA"
# sudo sh cuda_11.6.2_510.47.03_linux.run --silent

# echo "Remove CUDA install file"
# rm cuda_11.6.2_510.47.03_linux.run

echo "Setting CUDA path variables"

echo "export CUDA_HOME=\"/usr/local/cuda-11.6/bin\"" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\"/usr/local/cuda-11.6/lib64:$LD_LIBRARY_PATH\""  >> ~/.bashrc
echo "export PATH=\"$CUDA_HOME:$PATH"\" >> ~/.bashrc
