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
CRF="28"                                    # Bitrate de la vidéo en sortie
FPS="30"                                       # FPS de la vidéo en sortie
QUAL="medium"                                  # Preset de qualité FFMPEG
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"  # URL de base RTMP youtube

SOURCE_URL="$1"
SOURCE="$(youtube-dl $SOURCE_URL --get-url)"
echo $SOURCE
KEY="tgty-v1sr-va5c-drz6"                                     # Clé à récupérer sur l'event youtube

ffmpeg \
    -i "$SOURCE" \
    -codec:v libx264 \
    -preset $QUAL \
    -maxrate ${VIDEO_MAXRATE}k \
    -bufsize ${BUFFER_SIZE}k \
    -pix_fmt yuv420p \
    -g $(($FPS * 2)) \
    -crf $CRF \
    -codec:a libmp3lame \
    -threads 6 \
    -b:a ${AUDIO_RATE}k \
    -ar 44100 \
    -f flv \
    "$YOUTUBE_URL/$KEY"
