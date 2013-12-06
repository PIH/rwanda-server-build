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

Setup

1. Display instructions for password-less file transfer (setup-keys.sh)
2. Create directory structure (setup-folder.sh)
3. Install git, maven, and 7-zip (apt-get install git maven p7zip-full)

Puppet setup of OpenMRS server

1. Choose and get latest appropriate of OpenMRS database -- de-identified, trimmed, metadata only
2. Get latest version of OpenMRS software (war and modules)
3. Stop tomcat 
4. Cleanup tomcat directories (webapps/openmrs, work, temp, logs?)
5. Copy software to tomcat
6. Source database
7. Start tomcat

Manifest

README.md:						General description (this file)
staging-scripts/
  crontab:						Crontab for the nightly copy 
  nightly-copy.sh:		Nightly copy of war, modules, databases
  setup-folders.sh:		Setup directories for staging server
  setup-keys.sh 			Instructions for password-less setup
conf
  rwanda.sh:					Specific variables for Rwanda (2 production servers)
  rwanda-local.sh: 		Similar to previous file, but with local IP addresses and ports
