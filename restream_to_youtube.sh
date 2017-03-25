#! /bin/bash
#
# Diffusion youtube avec ffmpeg

# Configurer youtube avec une résolution 720p. La vidéo n'est pas scalée.

DOWNLOAD_RATE="800000"
UPLOAD_RATE="2000" # Seems to be enough to highest quality City stream
AUDIO_RATE="128"
# assume 80% reliable capacity of upload
VIDEO_MAXRATE=$((($UPLOAD_RATE * 80/100) - $AUDIO_RATE))
# 1-2 seconds for gamings, 5s for static (meetings)
# youtube recommends 2 sec
BUFFER_TIME="2"
BUFFER_SIZE=$(($BUFFER_TIME * $VIDEO_MAXRATE))

# 21-28 recommended (28 is lower qual)
CRF="21"                                    # Bitrate de la vidéo en sortie
FPS="30"                                       # FPS de la vidéo en sortie
QUAL="medium"                                  # Preset de qualité FFMPEG
RTMP_SERVER_URL="rtmp://a.rtmp.youtube.com/live2"  # URL de base RTMP youtube

VIDEO_URL="$1"
# DASH is a special format the YouTube seems to offer after the livestream. Our
# tool, `ffmpeg` doesn't seem to know how to use it, so we ignore those streams.
STREAM_URL="$(youtube-dl $VIDEO_URL --get-url --youtube-skip-dash-manifest)"
STREAM_KEY="$YOUTUBE_STREAM_KEY"                                     # Clé à récupérer sur l'event youtube

# -strict 2 allows experimental acc audio codec to be used
# -threads 0 allows ffmpeg to choose optimal number for codec

ffmpeg \
    -i "$STREAM_URL" \
    -codec:v libx264 \
    -preset $QUAL \
    -maxrate ${VIDEO_MAXRATE}k \
    -bufsize ${BUFFER_SIZE}k \
    -pix_fmt yuv420p \
    -g $(($FPS * 2)) \
    -crf $CRF \
    -strict -2 \
    -codec:a aac \
    -threads 0 \
    -f flv \
    "$RTMP_SERVER_URL/$STREAM_KEY"
