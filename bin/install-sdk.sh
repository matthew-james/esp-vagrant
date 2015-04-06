#!/bin/bash

# Build the SDK
if ! [ -d /home/vagrant/esp-open-sdk ]
	then
		git clone https://github.com/pfalcon/esp-open-sdk.git /home/vagrant/esp-open-sdk
		cd /home/vagrant/esp-open-sdk
		make STANDALONE=$1
fi

# Add the sdk to the path
if ! grep -q '#esp-paths' /home/vagrant/.bashrc
then
    echo "#esp-paths
export PATH=$PATH:/home/vagrant/esp-open-sdk/xtensa-lx106-elf/bin
export XTENSA_TOOLS_ROOT='/home/vagrant/esp-open-sdk/xtensa-lx106-elf/bin'
export SDK_BASE='/home/vagrant/esp-open-sdk/sdk'
" >> /home/vagrant/.bashrc
    source /home/vagrant/.bashrc
fi

# Add a link to esptool
if ! [ -e /usr/bin/esptool ]; then
    sudo ln -s /home/vagrant/esp-open-sdk/esptool/esptool.py /usr/bin/esptool
fi
