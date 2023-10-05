# DriverSenseVirtualCamera
In response to the growing concern over driver drowsiness and distraction, the European Union has mandated that all new vehicles sold within its jurisdiction must be equipped with Driver Monitoring Systems (DMS). To advance the development of cloud-based DMS solutions, a workshop has been organized that will introduce a reference solution cloud architecture and utilize Amazon Web Services (AWS).

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
