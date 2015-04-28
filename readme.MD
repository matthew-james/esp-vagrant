A vagrant virtual machine for the esp8266 esp-open-sdk

Note: this is a WIP - Please file any issues with reproduction steps.

# Setup

## Download the VM

* [Download Virtualbox](https://www.virtualbox.org/wiki/Downloads)

* [Download Vagrant](http://www.vagrantup.com/downloads.html)

* Download this Repo:
	* With Git:

	    ````git clone https://github.com/matthew-james/esp-vagrant.git ~/esp-vagrant````

	* [Or download the zip](https://github.com/matthew-james/esp-vagrant/archive/master.zip)

* Open a terminal in this repo's folder before running the following commands.

## Initial Setup

Get the VendorId and ProductID for your usb-serial device:

    VBoxManage list usbhost

Edit config.yml with your settings.

Start the VM.

    vagrant up

The first time you run ````vagrant up```` vagrant will install the SDK.

You can login like this:

    vagrant ssh

# Usage

The sdk is installed in ````~/esp-open-sdk````.

Anything you put in the ````~/user_data```` folder is synced to your host machine.

To use the console, just type ````esp-console {baud}````, i.e.:

    esp-console 9600

There are guides for compiling and burning the source-code examples, nodemcu, and the Espressif demos [here](https://github.com/matthew-james/esp-vagrant/wiki/burning-firmware).


## FAQ

### I don't see the SDK.

You need to manually install the SDK after creating the VM.  Run ````esp-open-sdk install```` and it will install it.  The install will take ~1 hour, but you only need to do it once.

### My USB-Serial device isn't working.

First, make sure your ProductId and VendorId are set in config.yaml.  You can get these by running ````VBoxManage list usbhost````.

Next, you can check if Ubuntu recognizes the device.  Unplug, then replug your device and type ````dmesg```` within the VM.  The last message should say something like this:

````[15240.987262] usb 1-1: generic converter now attached to ttyUSB0````

If the ttyUSB* is not 0, you may need to modify your makefiles.  If you did not get a attached to * message at all, it is likely the drivers for your usb-serial device are missing.

You can try ````sudo modprobe usbserial vendor=0x4348 product=0x5523````, replacing the IDs with your own IDs from the VboxManage command.

If you receive a permissions error, check the owner and group of the serial port by running ````ls -al /dev/ttyUSB0```` - You may need to add your user to that group.

**Please submit issues or pull requests if your usb-serial device isn't working so support can be added.**
