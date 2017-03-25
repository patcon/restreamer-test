# YouTube Restreamer testing

The purpose of this repo is to experiment with how to restream City of
Toronto YouTube Live videos to a third-party RTMP endpoint.

Some potential use-cases:
* Send to third-party platform endpoint, like Twitch, as make use of
  their services to engage audience.
* Expose endpoint on server for consumption by local Open Broadcaster
  Software, to use the feed as one camera of a remixed broadcast.

## Requirements

Tested against a fresh DigitalOcean instance of Ubuntu 16.04, 512MB RAM.

## Setup

Add this to your hostsfile:

```
# /etc/hosts
138.197.136.92 restreamer.dev
```

Run these commands:

```
patcon@workstation~$ ssh root@restreamer.dev
root@workstation:~$ apt-get update && apt-get upgrade
root@workstation:~$ apt-get install python python-pip
root@workstation:~$ pip install youtube_dl
```

Get the URL of a live feed from here: https://www.youtube.com/live

```

```

## Usage

We are testing the `restream_to_youtube.sh` script on a remote machine
to get the best bandwidth. The `test.sh` script will upload the main
script to the server and then run it.

```
./test.sh
```

### References

* https://github.com/rg3/youtube-dl/issues/2124
* https://rg3.github.io/youtube-dl/download.html
