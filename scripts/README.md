Setup AWS Cloud9

 ## Verify the region ##
 - Open the AWS Cloud9 console
	 - From the top right corner of the console, confirm one of the following regions:
		 - `us-east-1 (N.Virginia)`
		 - ** predefined for this event `us-west-2 (Oregon)`**
		 - `ap-northeast-1 (Tokyo)`
		 - `eu-west-1 (Ireland)`
		 - `eu-central-1 (Frankfurt)`
	 - Choose the *nearest* region (unless you are assigned a specific region)


## Create a Cloud9 environment ##
 - Open [Cloud9 console](https://us-west-2.console.aws.amazon.com/cloud9control/home?region=us-west-2#/product_) 
 - Select `Create environment` in the top right corner of the Cloud9 dashboard

## Create environment ##
 - Enter a descriptive name for the name (e.g. `dms-workshop`)
 - For the environment type, select `New EC2 instance`
 - For the instance type, select `m5.large (8GiB RAM + 2vCPU)`


Please note that if you choose to use a t3 instance type you may run out of resources by the end of the workshop.


- For the platform, select `Ubuntu Server 18.04 LTS`
- For timeout, select `7 days`
- Leave other configurations as the default values and then select the `Create` button

![Setup - Create Environment](/static/setup-createenviro.png)



In VPC settings, select the default VPC. If the default VPC does not exist, create the VPC and subnet as follows. 


## Expand disk space ##
 - At the bottom of the screen, you will see `Admin:~/environment $` which is the Cloud9 (EC2) terminal

![Setup - Expand Disk Space](/static/setup-expand.png)

 - Once you execute the following commands in the Cloud9 terminal, it will expand the disk and restart the instance. 


Please wait until the instance has restarted, as you will see `Connecting...` while the instance is restarting.


```bash
wget https://awsj-iot-handson.s3-ap-northeast-1.amazonaws.com/kvs-workshop/resize_volume.sh	
chmod +x resize_volume.sh	
./resize_volume.sh	
```

 - After the instance has restarted, run the following command in the terminal to check the disk space

```bash
df -h
```
 - In the result of the command, make sure the size of `/` is `20GB` as follows

```bash
'Filesystem Size Used Avail Use% Mounted on'
'/dev/nvme0n1p1 20G 8.4G 11G 44% /'
```
## Install dependencies ##
 - Execute the following commands to update the package list and install the libraries needed to build the SDK

```bash
sudo apt update
sudo apt install -y \
  cmake \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-ugly \
  gstreamer1.0-tools \
  libgstreamer-plugins-base1.0-dev
```

