## Sample Application ##

"Stream Maker"

Let;s run the Amazon Kinesis Video Streams Producer SDK C++ sample application and upload a clip video.

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

 - Instead of the sample video above, you can also use your own recorded video as well.
 
If you want to use your own video with Amazon Rekognition Video, you would require H.264 as the encoded format.


## Upload video

Run the following command in the Cloud9 terminal to set the environment variables.

```bash
cd ~/amazon-kinesis-video-streams-producer-sdk-cpp/build
export GST_PLUGIN_PATH=$HOME/amazon-kinesis-video-streams-producer-sdk-cpp/build
export LD_LIBRARY_PATH=$HOME/amazon-kinesis-video-streams-producer-sdk-cpp/open-source/local/lib
```

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


![loopervideo](https://github.com/andyshahbazian/DriverSenseVirtualCamera/assets/16087670/b380cc11-5fac-4bf6-853b-1b2f801b4d15)
