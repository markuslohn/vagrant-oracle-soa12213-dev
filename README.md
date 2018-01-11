# vagrant-oracle-soa12113-dev

This vagrant configuration provides a CentOS 7 system with the following components:

* CentOS 7 without a desktop
* Oracle Java JDK 8
* Oracle SOA Quickstart 12.2.1.3
* git
* Apache Maven
* Flyway
* A well prepared WebLogic domain: soadev_domain with Java DB

Please use the user vagrant/vagrant to login into the virtual machine. welcome1 is used as
password for all Oracle components, like Fusion Middleware and Database.

Use JDeveloper located on your development machine to access the WebLogic domain inside the VM.
Port 7201 (WebLogic) and 1527 (JavaDB) are automatically exposed by the VM. Furthermore
the VM exposes other ports to enable remote debugging.

All bookmarks can be found in file index.html.

## Installation and Configuration Steps

1. Ensure Oracle Virtual Box is installed and configured on your development machine.
   ([http://www.oracle.com/technetwork/server-storage/virtualbox/downloads/index.html](http://www.oracle.com/technetwork/server-storage/virtualbox/downloads/index.html))

2. Ensure Vagrant is installed and configured on your development machine.
   ([https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html))

3. Download and install Oracle JDK 8 for your operating system from   
   [http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

4. Download SOA Quickstart Installer 12.2.1.3 from OTN and unpack the files to $HOME/Downloads
   http://download.oracle.com/otn/nt/middleware/12c/12213/fmw_12.2.1.3.0_soaqs_Disk1_1of2.zip
   http://download.oracle.com/otn/nt/middleware/12c/12213/fmw_12.2.1.3.0_soaqs_Disk1_2of2.zip

5. Install SOA Quickstart Installer 12.2.1.3 using the following command:

   ```
   $ java -jar $HOME/Downloads/fmw_12.2.1.3.0_soa_quickstart.jar
   ```

   Follow the instructions on the screen. It is recommended to use `$HOME/oracle/middleware/12.2.1.3/soaquickstart` as Oracle Home.

6. Clone the project from git. The target folder is named PROJECT_HOME afterwards.

   ```
   $ git clone https://git.esentri.com/scm/vm/vagrant-oracle-soa12213-dev.git
   ```

7. Copy and extract fmw_12.2.1.3.0_soaqs_Disk1_1of2.zip and fmw_12.2.1.3.0_soaqs_Disk1_2of2.zip to PROJECT_HOME/provision/OracleSOA-12.2.1.3

8. You can fine tune the configuration by open the vagrant file. The following settings can be modified when the default is not suitable:

   ```
    s.env = {SCRIPT_BASE: "/vagrant",
             ORACLE_BASE: "/opt/oracle",
             ORACLE_HOME: "/opt/oracle/middleware/12.2.1.3/soaquickstart",
             DOMAIN_NAME: "soadev_domain",
             ADMIN_PORT: "7201",
             ADMIN_NAME: "weblogic",
             ADMIN_PASSWORD: "weblogic1",
             JAVA_VERSION: "8u152",
             JAVA_BUILD_VERSION: "b16",
             JAVA_MD5: "aa0333dd3019491ca4f6ddbe78cdb6d0"}
   ```

9. Open a shell on your development machine and navigate to the folder vagrant-oracle-soa12213-dev. Startup the VM:

   ```
   $ vagrant up
   ```

10. Open the file PROJECT_HOME/index.html in a web browser

    This files contains all links and some other important information working with the VM.

## Usage

### Start Virtual Machine

1. Open a shell on your development machine and navigate to the folder vagrant-oracle-soa12213-dev

2. Execute start command

   ```
   $vagrant up
   ```

### Stop Virtual Machine

1. Open a shell on your development machine and navigate to the folder vagrant-oracle-soa12213-dev

2. Execute stop command

   ```
   $ vagrant halt
   ```

### Update Virtual Machine

1. Open a shell on your development machine and navigate to the folder vagrant-oracle-soa12213-dev

2. Pull the latest changes from the git repository

3. Execute the following command. The virtual machine must be started!

   ```
   $ vagrant rsync
   $ vagrant provision
   ```

### Post Installation Steps

#### Configure Oracle Maven Repository

The following steps only needed when using Maven inside the VM.

1. Register with Oracle OTN Account on http://www.oracle.com/webfolder/application/maven/index.html if not yet done.

2. Open a shell inside the virtual machine and encrypt your OTN password

   ```
   $ mvn --encrypt-master-password <password>
   ```

3. Copy the encrypted to the clipboard and paste it in the file $HOME/.m2/security-settings.xml in the element <master></master>.

4. Open a shell inside the virtual machine and encrypt your OTN password

   ```
   $ mvn --encrypt-password <password>
   ```

5. Copy the encrypted to the clipboard and paste it in the file $HOME/.m2/settings.xml in the element <password></password> for server definition maven.oracle.com.

6. Put your OTN account name in the file $HOME/.m2/settings.xml in the element <username></username> for server definition maven.oracle.com.

### Issues

Obtain and install the following patches from Oracle Support regardings the release 12.2.1.3:

- 27235959: Auf den Server, damit die One-Way Pipelines funktionieren.
- 26851310: Auf JDeveloper, um den DBAdapter verwenden zu können.
