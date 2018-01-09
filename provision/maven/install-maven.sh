#!/bin/bash

#
# install-maven.sh
# Installs Apache Maven on linux systems using yum and rpm.
#
# History
#   2017/12/29  mlohn     Created.
#
# Usage
#
#    install-maven.sh
#

if [ -z "$JAVA_HOME" ]
    then
      JAVA_HOME=/usr/java/latest
fi

if [ `rpm -qa | grep maven | wc -l` -eq 0 ]
  then
     echo "Installing Apache Maven ..."
     sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
     sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
     sudo yum -y -t install apache-maven > /dev/null
fi

if ! [ -f "/tmp/certfile.txt" ]
   then
     echo "Installing certificate for esentri Artifactory..."
     openssl s_client -connect repo.esentri.com:443 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /tmp/certfile.txt
     sudo $JAVA_HOME/bin/keytool -import -alias "repo.esentri.com" -file /tmp/certfile.txt -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt
fi
