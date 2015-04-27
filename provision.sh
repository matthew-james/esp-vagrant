#!/bin/bash

# Install required packages
sudo apt-get update
sudo apt-get -y install git make autoconf automake libtool gcc g++ gperf \
    flex bison texinfo gawk ncurses-dev libexpat-dev python sed unzip

# This package contains usbserial kernel drivers
# see http://ubuntu.5.x6.nabble.com/PATCH-0-2-linux-image-extra-support-td365008.html
sudo apt-get -y install linux-image-extra-virtual

# Give the vagrant user permissions for the serial ports
sudo adduser vagrant dialout

# Add our esp-open-sdk manager script to the bin
if ! [ -e /usr/bin/esp-open-sdk ]; then
    ln -s /vagrant/bin/esp-open-sdk /usr/bin/esp-open-sdk
fi

# Add our serial terminal script to the bin
if ! [ -e /usr/bin/esp-console ]; then
    ln -s /vagrant/bin/esp-console /usr/bin/esp-console
fi

#colorize the bash prompt - it's easier to tell if you are in the vm or not
echo "PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '" >> /home/vagrant/.bashrc

# Install the sdk as the vagrant user
sudo -u vagrant -i esp-open-sdk install
