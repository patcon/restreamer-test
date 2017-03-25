#!/usr/bin/env bash

YOUTUBE_URL='https://www.youtube.com/watch?v=jKrDfGoHlD4'

scp restream_to_youtube.sh root@restreamer.dev:~
ssh root@restreamer.dev "bash restream_to_youtube.sh $YOUTUBE_URL"
