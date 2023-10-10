#!/bin/bash
# combined_script.sh

# Step 1: Download and execute resize_volume.sh script
wget https://awsj-iot-handson.s3-ap-northeast-1.amazonaws.com/kvs-workshop/resize_volume.sh
chmod +x resize_volume.sh
./resize_volume.sh

# Step 2: After the instance has restarted, check the disk space
df -h

# In the result of the command, make sure the size of / is 20GB as follows
# 'Filesystem     Size  Used  Avail  Use%  Mounted on'
# '/dev/nvme0n1p1  20G   8.4G   11G   44%   /'

# Step 3: Install dependencies
# Execute the following commands to update the package list and install the libraries needed to build the SDK
sudo apt update
sudo apt install -y \
  cmake \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-ugly \
  gstreamer1.0-tools \
  libgstreamer-plugins-base1.0-dev
