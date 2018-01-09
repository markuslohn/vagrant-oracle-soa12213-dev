#!/bin/bash

#
# provision.sh
# Prepares the Linux OS and controls the VM provision process.
#
# History
#   2017/12/27  mlohn     Created.
#
# Usage
#
#    provision.sh
#

if ! [ $(id -u) = 0 ]; then
   echo "This script must be run as root."
   exit 1
fi

echo "Installing which..."
sudo yum -y -t install which > /dev/null
echo "Installing wget..."
sudo yum -y -t install wget > /dev/null
echo "Installing curl..."
sudo yum -y -t install curl > /dev/null
echo "Installing git ..."
sudo yum -y -t install git > /dev/null

cd /vagrant/provision/OracleJava && source ./install-java8.sh
cd /vagrant/provision/maven && source ./install-maven.sh
cd /vagrant/provision/flyway && source ./install-flyway.sh
cd /vagrant/provision/OracleSOA-12.2.1.3 && su -c "source ./install-oracle-soa.sh" vagrant
