# DriverSenseVirtualCamera

Overview

To advance the development of cloud-based DMS (Driver Monitoring System) solutions, a crucial prerequisite is the seamless integration of an in-cabin camera for monitoring the driver's alertness level, including detecting signs of drowsiness, such as a tilting head.

Motivation

Developers encounter the challenge of harnessing a camera to capture and analyze these real-time events effectively. Leveraging technologies like Kinesis Video Stream and Rekognition Live necessitates unfettered access to live data. To address this need, we offer a simulator that continuously replays a video clip, emulating a live camera feed to provide real-time data. Furthermore, we furnish all the essential provisioning and an integrated development environment (Cloud9) to streamline the setup process, making it quick and hassle-free.

Requirements

Installation of a camera facing the driver's seat inside the vehicle.
Capture of live video footage, encompassing the driver and other passengers.
Real-time transmission of the video stream to a Kinesis Video Stream.
Limitations

To further utilize this simulator within a cloud environment, such as testing your Rekognition application, we recommend exploring our DMS accelerator. This comprehensive resource covers additional AWS technologies and scenarios, including:

Rekognition: Employing facial recognition to identify the driver's face among other passengers in the vehicle.
Facial Data Transmission: Utilizing Kinesis Data Stream to send facial data, including drowsiness detection. This includes the confidence score of recognition, utilizing the pitch, yaw, and roll angles of the driver's face.
Please note: In-vehicle deployments necessitate some level of edge ML (Machine Learning), such as OpenCV, to handle immediate dangers. Typically, video streams are sent to the cloud for attestation, verification, and compliance purposes.


---
Setup Kinesis Video Streamer'
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
  
Now that you have set up Amazon Kinesis Video Streams Producer SDK C++, we can 
