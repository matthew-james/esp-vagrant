# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

dir = File.dirname(File.expand_path(__FILE__))

userConfig = YAML.load_file("#{dir}/config.yaml")

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.synced_folder "./user_data", "/home/vagrant/user_data"

  config.vm.provider :virtualbox do |vb|
    vb.memory = userConfig['vm']['memory']
    vb.cpus = userConfig['vm']['cpus']
    vb.customize ['modifyvm', :id, '--usb', 'on']
    vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'USB_to_TTL_converter', '--vendorid', userConfig['usb-serial']['vendor_id'], '--productid',  userConfig['usb-serial']['product_id']]
  end

  config.vm.provision "shell" do |s|
    s.path = "./provision.sh"
  end
end
