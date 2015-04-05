A vagrant virtual machine for the esp8266 esp-open-sdk

Note: this is a WIP - Please file any issues with reproduction steps.

# Setup

## Initial Setup

Get the VendorId and ProductID for your usb-serial device:

    VBoxManage list usbhost

Edit config.yml with your settings.

Start the VM.

    vagrant up

You can login like this:

    vagrant ssh

## Install the SDK

The first time you login you need to install the SDK.

You can do so like this:

    esp-open-sdk install

If you don't want to build the standalone SDK, you can pass ````-s n````.

# Usage

The sdk is installed in ````~/esp-open-sdk````.

Anything you put in the ````~/user_data```` folder is synced to your host machine.

To use the console, just type ````esp-console {baud}````, i.e.:

    esp-console 9600


## FAQ

### I don't see the SDK.

You need to manually install the SDK after creating the VM.  Run ````esp-open-sdk install```` and it will install it.  The install will take ~1 hour, but you only need to do it once.

### Why not install the SDK on vagrant provision?

It seems to have problems everytime I try to install on provision.  Also, it's really hard to read because the spinner creates a new line when provisioning.

### My USB-Serial device isn't working.

First, make sure your ProductId and VendorId are set in config.yaml.  You can get these by running ````VBoxManage list usbhost````.

Next, you can check if Ubuntu recognizes the device.  Unplug, then replug your device and type ````dmesg```` within the VM.  The last message should say something like ````[15240.987262] usb 1-1: generic converter now attached to ttyUSB0````.  If the ttyUSB* is not 0, you may need to modify your makefiles.  If you did not get a attached to * message at all, it is likely the drivers for your usb-serial device are missing.

You can try ````sudo modprobe usbserial vendor=0x4348 product=0x5523````, replacing the IDs with your own IDs from the VboxManage command.

If you receive a permissions error, check the owner and group of the serial port by running ````ls -al /dev/ttyUSB0```` - You may need to add your user to that group.
