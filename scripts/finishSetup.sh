#!/bin/bash

export DOMAINNAME=xmpp

sudo service openfire stop  
while curl -s http://${DOMAINNAME}:9090/index.jsp; do
	echo "still waiting for Openfire to be stopped: `date`"
	sleep 2
done
 
     # inject configuration
#     sudo -u openfire cp -a /usr/share/openfire/conf/openfire.xml /usr/share/openfire/conf/openfire.xml.orig
#     sudo -u openfire cp -a /vagrant/data//openfire/conf/openfire.xml /usr/share/openfire/conf/openfire.xml

     # setup database ... start with stored db and replace some placeholders
 #    sudo -u openfire cp -a /vagrant/data/openfire/hsqldb/* /usr/share/openfire/embedded-db/
 #    sudo sed -i "s/REPLACE_XMPP_DOMAIN/${DOMAINNAME}/g" /usr/share/openfire/embedded-db/openfire.script
 #    sudo sed -i "s/REPLACE_ADMIN_PASSWORD/Pass1234/g" /usr/share/openfire/embedded-db/openfire.script 

     # Install Openfire-Server-Plugins ... restart needed to activate the plugins
sudo -u openfire cp /vagrant/data/openfire/plugins/restAPI.jar /usr/share/openfire/plugins
##     sudo -u openfire cp /vagrant/data/openfire/plugins/xmldebugger.jar /usr/share/openfire/plugins
sudo -u openfire cp /vagrant/data/openfire/plugins/search.jar /usr/share/openfire/plugins
sudo -u openfire cp /vagrant/data/openfire/plugins/dbaccess.jar /usr/share/openfire/plugins
sudo -u openfire cp /vagrant/data/openfire/plugins/ofmeet.jar /usr/share/openfire/plugins
sudo -u openfire cp /vagrant/data/openfire/plugins/jmxweb.jar /usr/share/openfire/plugins

# needed after Plugin-Installation     
sudo service openfire start

# configure plugins ...
while ! curl -s http://${DOMAINNAME}:9090/index.jsp; do
	echo "still waiting for Openfire started: `date`"
	sleep 2
done

# it takes some time until the rest-api plugin is visible in UI
sleep 60

# configure restAPI: enable it with Basic-Auth
curl -H "Content-Type: application/x-www-form-urlencoded" -u admin:Pass1234 -X POST -d 'enabled=true&authtype=true&secret=&allowedIPs=' http://${DOMAINNAME}:9090/plugins/restapi/rest-api.jsp?save

# configure jmxweb via rest-api: enable it
curl -H "Content-Type: application/xml" -u admin:Pass1234 -X POST -d '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><property key="xmpp.jmx.enabled" value="true"/>' http://${DOMAINNAME}:9090/plugins/restapi/v1/system/properties
