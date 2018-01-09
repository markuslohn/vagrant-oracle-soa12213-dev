#!/bin/bash

#
# create-wls-domain.sh
# A wrapper script to create a WebLogic server development domain with WLST.
#
# History
#   2017/05/09  mlohn     Created
#   2017/12/27  mlohn     Re-factored.
#
# Usage
#
#    create-wls-domain.sh
#

if [ -z "$ORACLE_HOME" ]
   then
     echo "Environment variable ORACLE_HOME was not set!"
     exit 1
fi
if [ -z "$DOMAIN_NAME" ]
   then
     export DOMAIN_NAME=soadev_domain
fi

export DOMAIN_HOME=$ORACLE_HOME/user_projects/domains/$DOMAIN_NAME

if [ ! -d "$DOMAIN_HOME" ] && [ -f "$ORACLE_HOME/jdeveloper/jdev/bin/jdev" ]
  then
     echo "Create WebLogic domain " $DOMAIN_NAME " in " $DOMAIN_HOME "..."
     $ORACLE_HOME/oracle_common/common/bin/wlst.sh create-wls-domain.py --oracleHome $ORACLE_HOME --domainName $DOMAIN_NAME --adminUser $ADMIN_USER --adminPassword $ADMIN_PASSWORD --listenPort $ADMIN_PORT
     echo $DOMAIN_NAME " was successfully created."
fi
