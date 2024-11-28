#!/bin/bash

# Ensure the environment is set up correctly
echo "Setting up environment..."

# Install dependencies (if necessary)
echo "Installing necessary dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Install CUDA (if needed) - remove this section if Render supports GPU out of the box
echo "Installing CUDA and cuDNN for GPU..."
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-repo-ubuntu2004_11.8.0-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004_11.8.0-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda

# Check if GPU is available (optional)
python -c "import tensorflow as tf; print('GPUs Available:', tf.config.list_physical_devices('GPU'))"

# Start your application (Flask or any other app you're running)
echo "Starting application..."
gunicorn app:app --workers 3 --timeout 120 --log-level debug

# If you need to disable GPU usage (if no GPU is available), use this line instead:
# export CUDA_VISIBLE_DEVICES="-1" && gunicorn app:app --workers 3 --timeout 120 --log-level debug
