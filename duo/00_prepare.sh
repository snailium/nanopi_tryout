#! /bin/bash

SUDO=

if [[ `whoami` != "root" ]]; then
  SUDO=sudo
fi

# Install utilities
$SUDO apt-get update
$SUDO apt-get install -y git build-essential
