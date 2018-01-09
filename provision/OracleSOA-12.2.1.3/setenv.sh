#!/bin/sh


###  Common Environment, including JAVA, ANT etc...

if [ -z "${MW_HOME}" ]; then
  echo "Please set MW_HOME."
  return 1
fi

. "$MW_HOME/oracle_common/common/bin/commEnv.sh"


###  OSB / ConfigJar Tool Home directories

OSB_HOME="$MW_HOME/osb"
CONFIGJAR_HOME="$OSB_HOME/tools/configjar"

export OSB_HOME CONFIGJAR_HOME


###  System properties required by OSB

OSB_OPTS=
OSB_OPTS="$OSB_OPTS -Dweblogic.home=$WL_HOME/server"
OSB_OPTS="$OSB_OPTS -Dosb.home=$OSB_HOME"
OSB_OPTS="$OSB_OPTS -Djava.util.logging.config.class=oracle.core.ojdl.logging.LoggingConfiguration"
OSB_OPTS="$OSB_OPTS -Doracle.core.ojdl.logging.config.file=$CONFIGJAR_HOME/logging.xml"
OSB_OPTS="$OSB_OPTS -Djava.security.egd=file:///dev/urandom"

JAVA_OPTS="$JAVA_OPTS $OSB_OPTS"
export JAVA_OPTS

ANT_OPTS="$ANT_OPTS $OSB_OPTS"
export ANT_OPTS


###  classpath representing OSB

CLASSPATH="$CLASSPATH$CLASSPATHSEP$JAVA_HOME/lib/tools.jar"
CLASSPATH="$CLASSPATH$CLASSPATHSEP$MW_HOME/wlserver/server/lib/weblogic.jar"
CLASSPATH="$CLASSPATH$CLASSPATHSEP$MW_HOME/oracle_common/modules/internal/features/jrf_wlsFmw_oracle.jrf.wls.classpath.jar"

CLASSPATH="$CLASSPATH$CLASSPATHSEP$MW_HOME/soa/soa/modules/oracle.soa.common.adapters_11.1.1/oracle.soa.common.adapters.jar"
CLASSPATH="$CLASSPATH$CLASSPATHSEP$OSB_HOME/lib/servicebus.jar"


### classpath for ConfigJar tool

CLASSPATH="$CLASSPATH$CLASSPATHSEP$CONFIGJAR_HOME/configjar.jar"


### ANT classpath

LOCALCLASSPATH=$CLASSPATH


export CLASSPATH LOCALCLASSPATH
