#!/bin/bash
if ! [ -d /home/vagrant/esp-open-sdk ]; then
	echo "/home/vagrant/esp-open-sdk does not exist"
	exit 1
fi

cd /home/vagrant/esp-open-sdk
make clean
git pull
git submodule update
