# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty32"
  config.vm.box_check_update = "false"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 9090, host: 9090
  config.vm.network "forwarded_port", guest: 9091, host: 9091
  config.vm.network "forwarded_port", guest: 5222, host: 5222
  config.vm.network "forwarded_port", guest: 5223, host: 5223
  config.vm.network "forwarded_port", guest: 7070, host: 7070
  config.vm.network "forwarded_port", guest: 7443, host: 7443

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.1.99"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
  
     export DOMAINNAME=xmpp
	 echo "127.0.0.1 ${DOMAINNAME}" >> /etc/hosts
	 
     sudo apt-get update
     
     # install standard tools
     sudo apt-get install -y curl mc
     
     # install jdk >= 7
     sudo apt-get install -y default-jdk
     
     # following this documentation: http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html
     # ... problem: this requires input
     #sudo apt-get install python-software-properties
     #sudo add-apt-repository -y ppa:webupd8team/java
     #sudo apt-get update
     #sudo apt-get install -y oracle-java8-installer
     
     # Install Openfire-Server
     echo "install Openfire"
     sudo dpkg -i /vagrant/data/openfire/openfire_3.10.2_all.deb

     # Openfire Base Installation
     # I tried to do the base installation by sending the POST and GET as sone in interactive mode 
     # but it was not working (see below). 
     # Therefore I decided to do the base installation once manually, shutdown the openfire server 
     # and store the hsqldb. This hsqldb will be restored now.
#     sudo service openfire stop  
#     while curl -s http://${DOMAINNAME}:9090/index.jsp; do
#        echo "still waiting for Openfire to be stopped: `date`"
#        sleep 2
#     done
 
     # inject configuration
#     sudo -u openfire cp -a /usr/share/openfire/conf/openfire.xml /usr/share/openfire/conf/openfire.xml.orig
#     sudo -u openfire cp -a /vagrant/data//openfire/conf/openfire.xml /usr/share/openfire/conf/openfire.xml

     # setup database ... start with stored db and replace some placeholders
 #    sudo -u openfire cp -a /vagrant/data/openfire/hsqldb/* /usr/share/openfire/embedded-db/
 #    sudo sed -i "s/REPLACE_XMPP_DOMAIN/${DOMAINNAME}/g" /usr/share/openfire/embedded-db/openfire.script
 #    sudo sed -i "s/REPLACE_ADMIN_PASSWORD/Pass1234/g" /usr/share/openfire/embedded-db/openfire.script 

     # Install Openfire-Server-Plugins ... restart needed to activate the plugins
#     sudo -u openfire cp /vagrant/data/openfire/plugins/restAPI.jar /usr/share/openfire/plugins
##     sudo -u openfire cp /vagrant/data/openfire/plugins/xmldebugger.jar /usr/share/openfire/plugins
#     sudo -u openfire cp /vagrant/data/openfire/plugins/search.jar /usr/share/openfire/plugins
##     sudo -u openfire cp /vagrant/data/openfire/plugins/dbaccess.jar /usr/share/openfire/plugins
#     sudo -u openfire cp /vagrant/data/openfire/plugins/ofmeet.jar /usr/share/openfire/plugins
#     sudo -u openfire cp /vagrant/data/openfire/plugins/jmxweb.jar /usr/share/openfire/plugins

     # needed after Plugin-Installation     
#     sudo service openfire start

     # configure plugins ...
#     while ! curl -s http://${DOMAINNAME}:9090/index.jsp; do
#        echo "still waiting for Openfire started: `date`"
#        sleep 2
#     done

     # configure jmxweb: enable it
#     curl -H "Content-Type: application/xml" -u admin:Pass1234 -X POST -d '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><property key="xmpp.jmx.enabled" value="true"/>' http://${DOMAINNAME}:9090/plugins/restapi/v1/system/properties

     # configure restAPI: enable it with Basic-Auth
 #    curl -H "Content-Type: application/x-www-form-urlencoded" -u admin:Pass1234 -X POST -d 'enabled=true&authtype=true&secret=&allowedIPs=' http://${DOMAINNAME}:9090/plugins/restapi/rest-api.jsp?save

# System property setzen log.debug.enabled
  SHELL
end
