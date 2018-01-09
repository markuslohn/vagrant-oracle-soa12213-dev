#!/bin/bash

#!/bin/bash

#
# install-oracle-soa.sh
# Installs and configures Oracle SOA Quickstart.
#
# History
#   2017/12/29  mlohn     Created.
#   2018/01/08  mlohn     Changed version to 12.2.1.3
#
# Usage
#
#    install-oracle-soa.sh
#

if ! [ -d "$ORACLE_HOME" ]
   then
      echo "Create " $ORACLE_HOME "..."
      sudo mkdir -p $ORACLE_BASE
      sudo chown -R vagrant $ORACLE_BASE
      sudo chgrp -R vagrant $ORACLE_BASE
      mkdir -p $ORACLE_HOME
fi

if [ -z "$JAVA_HOME" ]
    then
      JAVA_HOME=/usr/java/latest
fi

if ! [ -f "$ORACLE_HOME/jdeveloper/jdev/bin/jdev" ]
  then
     if [ -f "$SOASCRIPT_PATH/fmw_12.2.1.3.0_soaqs_Disk1_1of2.zip" ]
      then
         $JAVA_HOME/bin/jar -xf $SOASCRIPT_PATH/fmw_12.2.1.3.0_soaqs_Disk1_1of2.zip
     fi
     if [ -f "$SOASCRIPT_PATH/fmw_12.2.1.3.0_soaqs_Disk1_2of2.zip" ]
      then
         $JAVA_HOME/bin/jar -xf $SOASCRIPT_PATH/fmw_12.2.1.3.0_soaqs_Disk1_2of2.zip
     fi
     if [ -f "./fmw_12.2.1.3.0_soa_quickstart.jar" ]
       then
          echo "Installing SOA Quickstart 12.2.1.3..."
          cp ./oraInst.loc /tmp
          cp ./soa.rsp /tmp
          $JAVA_HOME/bin/java -jar ./fmw_12.2.1.3.0_soa_quickstart.jar -silent -invPtrLoc /tmp/oraInst.loc -responseFile /tmp/soa.rsp -ignoreSysPrereqs ORACLE_HOME=$ORACLE_HOME
          rm /tmp/oraInst.loc /tmp/soa.rsp
          cp -f ./setenv.sh $ORACLE_HOME/osb/tools/configjar
       else
         echo "SOA Quickstart 12.2.1.3 have to be downloaded and extracted to OracleSOA-12.2.1.3."
     fi
fi

if [ -f "$ORACLE_HOME/jdeveloper/jdev/bin/jdev" ]
  then
     source ./create-wls-domain.sh
     source ./wlsctl.sh start

     if ! [ -f "$HOME/wlsctl.sh" ]
        then
           cp -f ./wlsctl.sh $HOME
           chmod +x $HOME/wlsctl.sh
     fi
     if ! [ -f ~/.bash_aliases ]
        then
           echo "Configure Aliases in .bash_aliases..."
           touch ~/.bash_aliases
           echo "if [ -f ~/.bash_aliases ]; then" >> ~/.bashrc
           echo "      . ~/.bash_aliases" >> ~/.bashrc
           echo "fi" >> ~/.bashrc
     fi
     source ~/.bash_aliases
     if [ `alias | grep start | wc -l` -eq 0 ]
        then
          echo "alias start='$HOME/wlsctl.sh start'" >> ~/.bash_aliases
     fi
     if [ `alias | grep stop | wc -l` -eq 0 ]
        then
          echo "alias stop='$HOME/wlsctl.sh stop'" >> ~/.bash_aliases
     fi
     if [ `alias | grep status | wc -l` -eq 0 ]
        then
          echo "alias status='$HOME/wlsctl.sh status'" >> ~/.bash_aliases
     fi
     if [ `alias | grep dh | wc -l` -eq 0 ]
        then
          echo "alias dh='cd $DOMAIN_HOME'" >> ~/.bash_aliases
     fi
     if [ `alias | grep oh | wc -l` -eq 0 ]
        then
          echo "alias oh='export ORACLE_HOME=$ORACLE_HOME'" >> ~/.bash_aliases
     fi
     if [ `alias | grep dn | wc -l` -eq 0 ]
        then
          echo "alias dn='export DOMAIN_NAME=$DOMAIN_NAME'" >> ~/.bash_aliases
     fi
fi
