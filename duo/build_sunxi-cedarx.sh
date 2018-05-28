#! /bin/bash

SUDO=

if [[ `whoami` != "root" ]]; then
  SUDO=sudo
fi

$CEDRUS_DIR=$HOME/cedrus
if [ ! -e ${CEDRUS_DIR} ]; then
  mkdir -p ${CEDRUS_DIR}
fi

# Build CedarX
#
# See:
# http://linux-sunxi.org/CedarX
# http://linux-sunxi.org/CedarX/Kernel_Driver_guide
#
# Source:
#   sunxi-cedarx: https://github.com/allwinner-zh/media-codec
$SUDO apt-get install -y libtool automake

git clone https://github.com/allwinner-zh/media-codec.git ${CEDRUS_DIR}/media-codec
cd ${CEDRUS_DIR}/media-codec/sunxi-cedarx/SOURCE/
./bootstrap
make && $SUDO make install && $SUDO ldconfig



