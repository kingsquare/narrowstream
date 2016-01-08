#! /bin/bash
#
export LD_LIBRARY_PATH=/opt/ffmpeg
export PATH=/opt/ffmpeg:$PATH

VIDEO_INPUT="/dev/video0"
AUDIO_INPUT="hw:1"          # RPI: hw:1 / PC find via `cat /proc/asound/cards` and choose the right one
STREAM_PROTOCOL="rtmp"
STREAM_HOST="a.rtmp.youtube.com"
STREAM_URL="/live2/${YOUTUBE_KEY}"

ffmpeg -threads 2 -fflags nobuffer \
    -f v4l2 -thread_queue_size 512 -input_format h264 -r 30 -video_size 1920x1080 -i ${VIDEO_INPUT} \
    -f alsa -thread_queue_size 512 -ac 2 -re -ar 44100 -i ${AUDIO_INPUT} -flags +global_header -ar 44100 -ab 128k -codec:a aac -strict experimental \
    -codec:v copy -b:v 4500k -vsync vfr -r 30 \
    \
    -f flv -minrate 4500k -maxrate 4500k -bufsize 6500k ${STREAM_PROTOCOL}://${STREAM_HOST}${STREAM_URL}
