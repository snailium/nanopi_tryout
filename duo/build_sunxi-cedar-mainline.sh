#! /bin/bash

SUDO=

if [[ `whoami` != "root" ]]; then
  SUDO=sudo
fi

$CEDRUS_DIR=$HOME/cedrus
if [ ! -e ${CEDRUS_DIR} ]; then
  mkdir -p ${CEDRUS_DIR}
fi

# Build sunxi-cedar-mainline
#
# Source:
#   https://github.com/noblock/sunxi-cedar-mainline
MODULE_DIR=/lib/module/`uname -r`

$SUDO git clone https://github.com/friendlyarm/linux.git -b sunxi-4.14.y --depth 1 /usr/src/linux

if [ -e ${MODULE_DIR}/build ]; then
  $SUDO rm -rf ${MODULE_DIR}/build
fi
$SUDO ln -s /usr/src/linux ${MODULE_DIR}/build

cd /usr/src/linux
$SUDO touch .scmversion
$SUDO make sunxi_defconfig
$SUDO make prepare
$SUDO make modules_prepare

git clone https://github.com/noblock/sunxi-cedar-mainline.git ${CEDRUS_DIR}/sunxi-cedar-mainline
cd ${CEDRUS_DIR}/sunxi-cedar-mainline
$SUDO make KDIR=${MODULE_DIR}/build -f Makefile.linux
$SUDO make install KDIR=${MODULE_DIR}/build -f Makefile.linux
$SUDO depmod -a


