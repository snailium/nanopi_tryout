#! /bin/bash

# Depending on camera modules
#   - GC2035 (SD)
#   - OV5640 (HD)
#
# However, Armbian doesn't enable camera correctly.
# So extra GPIO setup is required.

SUDO=

if [[ `whoami` != "root" ]]; then
  SUDO=sudo
fi

# ===============
# Block camera module and v4l2 module from /etc/modules
# ===============
# gc2035
# ov5640
# vfe_v4l2

# ===============
# Enable camera properly in /etc/rc.local
# ===============
# patch: sunxi-pio -m "PG11<1><0><1><1>"
# patch: #modprobe gc2035
# patch: modprobe ov5640
# patch: modprobe vfe_v4l2

# ===============
# Prepare FFmpeg
# ===============
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
