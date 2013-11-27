server-build
===================

Build scripts for PIH OpenMRS servers (reporting, test, demo, dev, etc)

Assumptions

1. Use puppet for building servers and updating openmrs?
2. Use scripts and cron for building staging server with latest versions of war, omods and db 
3. Trim database nightly on staging server

Questions

1. How do we handle errors or recover from incomplete builds?
2. Which user should run the scripts -- for staging server and puppet scripts?

Steps

1. Get latest version of OpenMRS database -- de-identified, trimmed, metadata only
2. Get latest version of OpenMRS software (war and modules)
3. Stop tomcat 
4. Cleanup tomcat directories (webapps/openmrs, work, temp, logs?)
5. Copy software to tomcat
6. Source database
7. Start tomcat

Setup steps

1. Password-less file transfer

(see private/directions.txt)

Manifest
========

README.md:			General description (this file)
staging-scripts/
  setup-folders.sh:		Setup directories for staging server
  nightly-copy.sh:		Nightly copy of war, modules, databases 
  crontab:				Crontab for the nightly copy 
private
  config-rwanda.sh:		Specific variables for Rwanda and 2 production servers
  directions.txt:		Instruction for password-less setup