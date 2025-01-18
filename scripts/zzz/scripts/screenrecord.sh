#!/bin/bash

timestamp=$(date +"%Y%m%d-%H%M%S")
file_path="/home/adi/videos/screenrecords/$timestamp.mp4"
wf-recorder --audio --file="$file_path" &
notify-send --app-name=Screenrecorder --expire-time=1200 "Screen-recording is in progress"
