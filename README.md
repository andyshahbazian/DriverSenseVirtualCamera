# DriverSenseVirtualCamera

Overview 

To advance the development of cloud-based DMS (Driver Monitoring System) solutions, a fundamental requirement is the integration of an in-cabin camera to monitor the driver's level of alertness. For instance, detecting if the driver's head is tilting down due to drowsiness. Developers face the challenge of utilizing a camera to capture and analyze these events in real-time. Leveraging technologies like Kinesis Video Stream and Rekognition Live, this demands seamless access to live data. To facilitate this, we offer a simulator that continuously replays a video clip, simulating a live camera feed to provide real-time data. Additionally, we provide all the necessary provisioning and an integrated development environment (Cloud9) to ensure a quick and hassle-free setup process.

---
title: 'Setup Kinesis Video Streamer'
weight: 31
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
 ::::alert{type="info" header="Time Elapsed"}
`cmake` may take about 5 to 10 minutes to complete.
:::: 

 - As soon as the above commands have finished running, run the command below to complete building the SDK.

```bash
make
```
  
Now that you have set up Amazon Kinesis Video Streams Producer SDK C++, proceed to the next section.
