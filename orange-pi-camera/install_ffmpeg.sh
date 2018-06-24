#! /bin/bash

SUDO=

if [[ `whoami` != "root" ]]; then
  SUDO=sudo
fi

${SUDO} cp ffmpeg/ffmpeg ffmpeg/ffprobe /usr/bin

