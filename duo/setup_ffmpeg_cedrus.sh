#! /bin/bash

SUDO=

if [[ `whoami` != "root" ]]; then
  SUDO=sudo
fi

$CEDRUS_DIR=$HOME/cedrus
if [ ! -e ${CEDRUS_DIR} ]; then
  mkdir -p ${CEDRUS_DIR}
fi


# See:
#
# https://blog.danman.eu/orangepi-h264-hw-encoding-with-ffmpeg/
# https://github.com/danielkucera/FFmpeg/tree/cedrus264-v2
#
# http://linux-sunxi.org/FFmpeg
# https://github.com/stulluk/FFmpeg-Cedrus
#
# https://github.com/uboborov/ffmpeg_h264_H3
#

$SUDO apt-get install -y libmp3lame-dev libpulse-dev libv4l-dev libx264-dev libvdpau-dev libasound2-dev vlc

git clone -b cedrus264-v2 https://github.com/danielkucera/FFmpeg.git ${CEDRUS_DIR}/ffmpeg
${CEDRUS_DIR}/ffmpeg

./configure --prefix=/usr --enable-nonfree --enable-gpl --enable-version3 --enable-vdpau --enable-libx264 --enable-libmp3lame --enable-libpulse --enable-libv4l2
make -j 4 && $SUDO make install

#ffmpeg -f v4l2 -video_size 1920x1080 -i /dev/video0 -pix_fmt nv12 -r 60 -f alsa -ac 2 -i pulse -acodec aac -strict experimental -c:v cedrus264 -b:v 2M -f mpegts - | cvlc - --sout "#:rtp{sdp=rtsp://:8554/}"

