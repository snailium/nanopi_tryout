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
if ! grep "enabling camera" /etc/rc.local ; then
  ${SUDO} sed -i -e '$i \# enabling camera' /etc/rc.local
  ${SUDO} sed -i -e '$i sunxi-pio -m \"PG11<1><0><1><1>\"' /etc/rc.local
  ${SUDO} sed -i -e '$i \#modprobe gc2035' /etc/rc.local
  ${SUDO} sed -i -e '$i modprobe ov5640' /etc/rc.local
  ${SUDO} sed -i -e '$i modprobe vfe_v4l2' /etc/rc.local
fi
