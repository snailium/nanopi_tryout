#! /bin/bash

SUDO=

if [[ `whoami` != "root" ]]; then
  SUDO=sudo
fi

FFMPEG_DIR=${HOME}/ffmpeg
${SUDO} apt-get install -y libmp3lame-dev libpulse-dev libv4l-dev libx264-dev libvdpau-dev libasound2-dev vlc

if [ -e ${FFMPEG_DIR} ]; then
  ${SUDO} rm -rf ${FFMPEG_DIR}
fi
git clone -b cedrus264-v2 https://github.com/danielkucera/FFmpeg.git ${FFMPEG_DIR}

cd ${FFMPEG_DIR}
./configure --prefix=/usr --enable-nonfree --enable-gpl --enable-version3 --enable-vdpau --enable-libx264 --enable-libmp3lame --enable-libpulse --enable-libv4l2
make -j 4 && ${SUDO} make install

# To stream with FFmpeg
# ffmpeg -f v4l2 -video_size 1920x1080 -i /dev/video0 -r 60 -f alsa -ac 2 -i hw:0,0 -acodec aac -strict experimental -pix_fmt nv12 -c:v cedrus264 -b:v 2M -f mpegts - | cvlc - --sout "#:rtp{sdp=rtsp://:8554/}"
