#! /bin/bash

# This script helps install NanoHat-OLED on Armbian

sudo apt-get update

# ==========
# Install dependencies for Pillow
#
# Follow: https://pillow.readthedocs.io/en/latest/installation.html#building-on-linux
sudo apt-get install -y python-dev python-setuptools libtiff5-dev libjpeg-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
#
# As per instruction:
#   Then see depends/install_raqm.sh to install libraqm.

# ==========
# Install FriendlyElec's library
git clone https://github.com/friendlyarm/NanoHatOLED.git
cd NanoHatOLED
sudo -H ./install.sh
