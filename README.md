# DriverSenseVirtualCamera

Overview

To advance the development of cloud-based DMS (Driver Monitoring System) solutions, a crucial prerequisite is the seamless integration of an in-cabin camera for monitoring the driver's alertness level, including detecting signs of drowsiness, such as a tilting head.

Motivation

Developers encounter the challenge of harnessing a camera to capture and analyze these real-time events effectively. Leveraging technologies like Kinesis Video Stream and Rekognition Live necessitates unfettered access to live data. To address this need, we offer a simulator that continuously replays a video clip, emulating a live camera feed to provide real-time data. Furthermore, we furnish all the essential provisioning and an integrated development environment (Cloud9) to streamline the setup process, making it quick and hassle-free.

Sample use case (the gray area is not part of the scope). 

![image](https://github.com/andyshahbazian/DriverSenseVirtualCamera/assets/16087670/17cf23a7-27c1-44b1-9c5f-da7e7c3ffb5d)

Requirements

Installation of a camera facing the driver's seat inside the vehicle.
Capture of live video footage, encompassing the driver and other passengers.
Real-time transmission of the video stream to a Kinesis Video Stream.
Limitations

To further utilize this simulator within a cloud environment, such as testing your Rekognition application, we recommend exploring our DMS accelerator which will cover additional AWS technologies and scenarios, including:

Rekognition: Employing facial recognition to identify the driver's face among other passengers in the vehicle.
Facial Data Transmission: Utilizing Kinesis Data Stream to send facial data, including drowsiness detection. This includes the confidence score of recognition, utilizing the pitch, yaw, and roll angles of the driver's face.
Please note: In-vehicle deployments necessitate some level of edge ML (Machine Learning), such as OpenCV, to handle immediate dangers. Typically, video streams are sent to the cloud for attestation, verification, and compliance purposes.

Prerequisits

AWS environment
 - You can open an account [here](https://portal.aws.amazon.com/billing/signup#/start/email)
 - An IAM user with administrator privileges
 - Basic knowledge of Linux command line operations
 - AWS CLI - please follow this [link](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions)
 - Python (3.8 or higher)

First we will start with the cloud based IDE env. 


**AWS Cloud9 is a cloud-based integrated development environment (IDE) that enables developers to write, run, and debug code from a web browser.** C9 provides a fully-managed development environment with a code editor, terminal, and a pre-configured runtime environment, eliminating the need for developers to install and configure complex development tools locally.

AWS Cloud9 also supports **collaboration features** that allow developers to share their development environment with other team members and work together on the same code in real time. It is integrated with other AWS services.

This makes it easy to develop, test, and deploy applications on the AWS Cloud.

##Setup Cloud 9##

 In this section, you will setup AWS Cloud9

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


![setup-createenviro](https://github.com/andyshahbazian/DriverSenseVirtualCamera/assets/16087670/dd5cf0ed-b3b2-4d34-b54b-f80488c60a48)



In VPC settings, select the default VPC. If the default VPC does not exist, create the VPC and subnet as follows. 


## Expand disk space ##
 - At the bottom of the screen, you will see `Admin:~/environment $` which is the Cloud9 (EC2) terminal

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


You have now successfully set up a Cloud9 environment.


## Obtain AWS Credentials

Please skip to the appropriate step, dependant on which AWS environment you use.

### A) If you are using an account by AWS workshop

If you are using an account by the AWS Workshop in an AWS event, you should follow this step and then skip step **B**.

-   Copy the credentials like below from  'Get AWS CLI credentials' click on 
'the link'  then copy and paste the credentials 'as is'  to  **Cloud9 terminal**

<img width="262" alt="cred1" src="https://github.com/andyshahbazian/DriverSenseVirtualCamera/assets/16087670/ac739667-d8f3-4d13-9735-fe92af0f025c">
<img width="829" alt="cred2" src="https://github.com/andyshahbazian/DriverSenseVirtualCamera/assets/16087670/68faef86-7057-483f-9ac6-127d1ab5d15b">


```bash
export AWS_DEFAULT_REGION=...
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_SESSION_TOKEN=...
```

### B) If you are using your own AWS account.

 - Use the AWS CLI to get temporary credentials to upload the video


Note that if you have not already set up the AWS CLI on  **the PC for operation**, follow the steps:  [Installing the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) and  [Configuring the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) .


 - In the terminal on the  **PC for operation,**  run the following commands

```bash
aws sts get-session-token
```

 - You will get the following results, so we will set this value to the Cloud9's environment variable

```json
{
  "Credentials": {
    "AccessKeyId": "...",
    "SecretAccessKey": "...",
    "SessionToken": "...",
    "Expiration": "2020-01-01T00:00:01Z"
  }
}
```

 - Next, open  **Cloud9 or Raspberry Pi terminal**  and execute the following commands

```bash
export AWS_DEFAULT_REGION="The region you use (e.g. us-west-2)"
export AWS_ACCESS_KEY_ID="The AccessKeyId value of the result above"
export AWS_SECRET_ACCESS_KEY="The SecretAccessKey value of the result above"
export AWS_SESSION_TOKEN="The SessionToken value of the result above"
```


Please note: he AWS CLI is used to get temporary credentials of the IAM user to simplify the procedure, but it is difficult to do this every time on a real camera device. In a real world use case, you can use a client certificate managed by AWS IoT to get the credentials.  [How to Eliminate the Need for Hardcoded AWS Credentials in Devices by Using the AWS IoT Credentials Provider](https://aws.amazon.com/jp/blogs/security/how-to-eliminate-the-need-for-hardcoded-aws-credentials-in-devices-by-using-the-aws-iot-credentials-provider/)


--
title : "Stream Maker"
weight : 32
---
In this step, run the Amazon Kinesis Video Streams Producer SDK C++ sample application and upload the video.

## Create a Stream

1.  Open  [Amazon Kinesis Video Streams console](https://console.aws.amazon.com/kinesisvideo/home#)
2.  Confirm the region is same as the region you selected in  the previous sections
3.  Click on the  `Video streams`  in the left menu and then click on the  `Create video stream`  button
4.  Fill in the form with the following information and click the  `Create video stream`  button
    -   Video Stream Name:  `dms-stream`
    -   Select  `default configuration`



## Download the video for playback

 - Instead of a real camera device, you will use a pre-recorded video clip. Run the following command in the terminal to download it to your Cloud9 environment


```bash
cd
wget  "https://github.com/DrivierMonitoringSystems/videos/blob/main/distracted.mp4?raw=true" --no-check-certificate
mv 'distracted.mp4?raw=true' distracted.mp4 
ls
```

You should be able to see distracted.mp4 in the list of files, left click and test if you can open the video in cloud9. 

 - Instead of the sample video above, you can also use your own recorded video(1) 


## Upload video

Run the following command in the Cloud9 terminal to set the environment variables.

```bash
cd ~/amazon-kinesis-video-streams-producer-sdk-cpp/build
export GST_PLUGIN_PATH=$HOME/amazon-kinesis-video-streams-producer-sdk-cpp/build
export LD_LIBRARY_PATH=$HOME/amazon-kinesis-video-streams-producer-sdk-cpp/open-source/local/lib
```
On the workshop studio screen, at the bottom of the page locate : Get AWS CLI credentials, click on the link copy the credentials from the popup screen workshop, then paste it in your Cloud9 termina and click enter.

Then run the following command to upload the video.

#### Loop through pre-recorded video

```bash
while true; do ./kvs_gstreamer_sample dms-stream ~/distracted.mp4 && sleep 10s; done
```

If you get an error, make sure you have set the AWS credentials as the environment variables you've set previously. and the stream name (`dms-stream`) is correct.

This video stream will be used in the following steps; leave the command running, or rerun it when you get to the next step.


## Check the video stream

1.  Open  [Amazon Kinesis Video Streams console](https://console.aws.amazon.com/kinesisvideo/home#/dashboard)
2.  Select  `Video streams`  in the left menu
3.  Select  `dms-stream`  in the list of streams
4.  Select  `Media playback`  part to expand it, and you'll see the video


![loopervideo](https://github.com/andyshahbazian/DriverSenseVirtualCamera/assets/16087670/bf741bdf-2796-4ccb-bfeb-31e73ca245e1)

 
---
Setup Kinesis Video Streamer
---
In this section, you will install Amazon Kinesis Video Streams Producer SDK C++ on your environment.

## Download the SDK

 - Execute the following commands in the Cloud9 terminal.

```bash
cd
git clone https://github.com/awslabs/amazon-kinesis-video-streams-producer-sdk-cpp.git
```

## Build the SDK

 - Execute the following commands to download and build the dependent libraries.

```bash
mkdir -p ~/amazon-kinesis-video-streams-producer-sdk-cpp/build
cd ~/amazon-kinesis-video-streams-producer-sdk-cpp/build
cmake -DBUILD_GSTREAMER_PLUGIN=ON ..
```
 :exclamation: **cmake may take about 5 to 10 minutes to complete.**

 - As soon as the above commands have finished running, run the command below to complete building the SDK.

```bash
make
```
  
Now that you have set up Amazon Kinesis Video Streams Producer SDK C++, you can proceed with testing your virtual camera and see your stream, feed it to Rekogniton or other ML applications. to develop advanceda application for automotive industry 



