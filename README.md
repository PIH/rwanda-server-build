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

1. Create $HOME/.envStaging
2. cp conf/env-template.conf to $HOME/.envStaging/[countryName].conf
3. Modify the configure file (ie. rwanda, malawi, etc.) for specific variables
4. Create $HOME/.envStaging/userlist.conf from conf/userlist.conf
5. [sudo] Create Linux users and install pre-requisitive software (sudo users-and-packages.sh)
4. Display instructions for password-less file transfer (setup-keys.sh)
5. Create directory structure (setup-folder.sh)

 

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
  crontab:				Crontab for the nightly copy 
  nightly-copy.sh:		Nightly copy of war, modules, databases
  setup-folders.sh:		Setup directories for staging server
  setup-keys.sh 		Instructions for password-less setup
conf
  env-template:			Template file with variables for build
