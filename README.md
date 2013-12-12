server-build
===================
Build scripts for PIH OpenMRS servers (reporting, test, demo, dev, etc)

This builds a directory hierarchy on the staging serverwith the appropriate version of OpenMRS, modules and databases.  This is created under $HOME/staging/$IMPLEMENTATION where IMPLEMENTATION = rwink, butaro, lower-neno, upper-neno, etc.

	warfile:	
	modules:	production and dev
	databases:	production, de-identified, trimmed, etc

Assumptions

1. Use puppet for building servers and updating openmrs?
2. Use scripts and cron for building staging server with latest versions of war, omods and db 
3. Trim database nightly on staging server

Questions

1. How do we handle errors or recover from incomplete builds?
2. Which user should run the scripts -- for staging server and puppet scripts?

Setup

Run these as "normal" user (ie. ball, tomcat6, openmrs, or whatever), except as noted:

mkdir $HOME/.envStaging
mkdir $HOME/Workspace
cd $HOME/Workspace
git clone https://github.com/PIH/openmrs-contrib-databaseexporter database-exporter
git clone https://github.com/PIH/staging-server-build.git

Setup configuration files 

1. cp $HOME/Workspace/staging-server-build/conf/env-template.conf $HOME/.envStaging/[countryName].conf
2. Modify the configure file (ie. rwanda, malawi, etc.) for specific variables
3. cp $HOME/Workspace/staging-server-build/conf/users.conf $HOME/.envStaging/.
4. Modify list of users and temporary password
5. Change crontab for the correct implementation(s)

Create Linux users and install pre-requisitive software 

cd $HOME/Workspace/staging-server-build/scripts
sudo ./users-and-packages.sh

Setup staging directories and security keys

1. Display instructions for password-less file transfer (setup-keys.sh)
2. Create directory structure (setup-folder.sh [implementation_name]) (ie.  setup-folder.sh rwink)

Install database export (install-db-exporter.sh)

1. cd $HOME/Workspace/database-exporter
2. mvn clean package -DskipTests
3. cp target/databaseexporter-1.0-SNAPSHOT-jar-with-dependencies.jar $HOME/staging/bin/.

Setup latest software and database - The cron will do this nightly.

1. Nightly copy of war, modules, and db (nightly-copy.sh) (ie. ./nightly-copy.sh rwink)
2. Initial setup of database (create-db-and-sql.sh) (ie. ./create-db-and-sql.sh rwink)

Puppet setup of OpenMRS server

1. Choose and get latest appropriate of OpenMRS database -- de-identified, trimmed, metadata only
2. Get latest version of OpenMRS software (war and modules)
3. Stop tomcat 
4. Cleanup tomcat directories (webapps/openmrs, work, temp, logs?)
5. Copy software to tomcat
6. Source database
7. Start tomcat

Manifest for staging-server-build

README.md:				General description (this file)
staging-scripts/
  nightly-copy.sh:		Nightly copy of war, modules, databases
  setup-folders.sh:		Setup directories for staging server
  setup-keys.sh 		Instructions for password-less setup
conf
  crontab:				Crontab for the nightly copy
  env-template.conf:	Template file with variables for each implementation
  staging.conf:			Specific variables for staging server
  users.conf:			Linux users and temporary password for staging server
  database-exporter/	Configuration files for the database export
  	README.md:			Documentation for using the database exporter
  	removeAllPatients.json
  	removeSyncData.json
  	mirebalais/
  	rwanda/