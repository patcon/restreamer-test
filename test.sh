#!/usr/bin/env bash

: ${YOUTUBE_STREAM_KEY?"Need to set YOUTUBE_STREAM_KEY"}

# Defaults to a Parks & Rec meeting video
YOUTUBE_URL=${1:-https://www.youtube.com/watch?v=24BUo3kkA10}

scp restream_to_youtube.sh root@restreamer.dev:~
ssh root@restreamer.dev "YOUTUBE_STREAM_KEY=$YOUTUBE_STREAM_KEY bash restream_to_youtube.sh $YOUTUBE_URL"
