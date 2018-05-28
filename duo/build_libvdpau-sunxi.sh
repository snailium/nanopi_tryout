#! /bin/bash

SUDO=

if [[ `whoami` != "root" ]]; then
  SUDO=sudo
fi

$CEDRUS_DIR=$HOME/cedrus
if [ ! -e ${CEDRUS_DIR} ]; then
  mkdir -p ${CEDRUS_DIR}
fi

# Build libvdpau-sunxi
#
# See:
#    http://linux-sunxi.org/Cedrus/libvdpau-sunxi
#
# Source:
#    https://github.com/linux-sunxi/libcedrus
#    https://www.cairographics.org/releases/
#    https://github.com/linux-sunxi/libvdpau-sunxi
$SUDO apt-get install -y vdpau-dev libpixman-1-dev
git clone https://github.com/linux-sunxi/libcedrus.git $CEDRUS_DIR/libcedrus
cd $CEDRUS_DIR/libcedrus
make && $SUDO make install

git clone https://github.com/linux-sunxi/libvdpau-sunxi.git $CEDRUS_DIR/libvdpau-sunxi
cd $CEDRUS_DIR/libvdpau-sunxi
make && $SUDO make install

