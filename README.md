staging-server-build
====================
This is used to stage software and databases for building PIH OpenMRS reporting, test, demo, and dev servers.  
Scripts and cron build server with latest versions of war, omods and databases, which are trimmed nightly.

===================
I.  Installation
===================
Run these as "normal" user (ie. ball, tomcat6, openmrs, or whatever), except as noted:

mkdir $HOME/.envStaging
mkdir $HOME/Workspace
cd $HOME/Workspace
git clone https://github.com/PIH/openmrs-contrib-databaseexporter database-exporter
git clone https://github.com/PIH/staging-server-build.git

These files are used to build the staging server and include in the stating-server-build package.  Only Rwanda 
database exporter configuration is complete and available in github, but Malawi and Haiti configuration will 
follow and simple to create.

staging-server-build/
├── conf
│   ├── crontab
│   ├── database-exporter
│   │   ├── builds
│   │   │   └── rwanda
│   │   │       ├── de-id-and-large.conf
│   │   │       ├── de-id-and-small.conf
│   │   │       ├── deidentify.conf
│   │   │       ├── full.conf
│   │   │       └── minimum.conf
│   │   ├── mirebalais
│   │   │   ├── addresses.config
│   │   │   └── deidentify.json
│   │   ├── README.md
│   │   ├── removeAllPatients.json
│   │   ├── removeSyncData.json
│   │   └── rwanda
│   │       ├── deidentify.json
│   │       ├── trimArchiveData.json
│   │       ├── trimPatientsLarge.json
│   │       ├── trimPatientsSmall.json
│   │       ├── trimProviders.json
│   │       └── trimUsers.json
│   ├── env-template.conf
│   ├── staging.conf
│   └── users.conf
├── README.md
└── scripts
    ├── drop-and-create.sql
    ├── install-db-exporter.sh
    ├── nightly-copy.sh
    ├── setup-folders.sh
    ├── setup-keys.sh
    ├── update-db-exporter.sh
    └── users-and-packages.sh

======================
II. Configuration  
======================

Some of the configuration files have private and secure information.  Template files are copied from
staging-server-build/conf/*.conf into the $HOME directory and modified:

1. cp $HOME/Workspace/staging-server-build/conf/env-template.conf $HOME/.envStaging/[countryName].conf
2. Modify the configure file (ie. rwanda, malawi, etc.) for specific variables
3. cp $HOME/Workspace/staging-server-build/conf/users.conf $HOME/.envStaging/.
4. Modify list of users and temporary password

=================================
III. Users and software packages
=================================
As root user, create Linux users and install pre-requisitive software:

modify $HOME/.envStaging/users.conf
cd $HOME/Workspace/staging-server-build/scripts
sudo ./users-and-packages.sh

=================================
IV. Password-less access
=================================
Setup ssh keys for password-less file transfer.  This is currently not automated, but very straightforward with running this script:

cd $HOME/Workspace/staging-server-build/scripts
./setup-keys.sh [butaro|rwink]

===============================
V. Create directory structure
===============================
A directory hierarchy is created on the staging server with the appropriate version of OpenMRS, modules and databases.  
It is is created under $HOME/staging/$IMPLEMENTATION where IMPLEMENTATION = rwink, butaro, lower-neno, upper-neno, etc.
Use this command and implementation parameter:  

cd $HOME/Workspace/staging-server-build/scripts
./setup-folder.sh [rwink|butaro]

This is an example of a staging area for 2 Rwanda implementations (rwink and butaro):

staging/
├── bin
├── logs
├── butaro
│   ├── database
│   │   ├── de-id-and-large
│   │   ├── de-id-and-small
│   │   ├── deidentify
│   │   ├── full
│   │   ├── minimum
│   │   └── production
│   ├── modules
│   │   ├── dev
│   │   └── production
│   └── warfile
└── rwink
    ├── database
    │   ├── de-id-and-large
    │   ├── de-id-and-small
    │   ├── deidentify
    │   ├── full
    │   ├── minimum
    │   └── production
    ├── modules
    │   ├── dev
    │   └── production
    └── warfile


======================================
VI. Build database export executable
======================================
Build the database export executable which quickly creates de-identified and trimmed databases.

cd $HOME/Workspace/staging-server-build/scripts
./install-db-exporter.sh

======================================
VII.  Update software and database 
======================================
To update to the latest war, modules, and all the various databases on the staging server, run these commands:

cd $HOME/Workspace/staging-server-build/scripts
./nightly-copy.sh [rwink|butaro|rwink-local|butaro-local]

rwink-local and butaro-local are similar to the other files, but with private IP addresses for faster file transfer.

====================================
VIII.  Automatic update
====================================
For an automatic nightly build, use the example crontab file.  Change the crontab (ie. time, date, MAILTO) for 
the correct implementation.

cd $HOME/Workspace/staging-server-build/conf
crontab crontab
crontab -l


=========================
Appendix:  Future tasks
=========================
1. Error recovery from incomplete builds.
2. Change user and $HOME for staging server and puppet scripts.
3. Use puppet for building servers and updating openmrs software and database.
  a. Choose and get latest appropriate of OpenMRS database -- de-identified, trimmed, metadata only
  b. Get latest version of OpenMRS software (war and modules)
  c. Stop tomcat 
  d. Cleanup tomcat directories (webapps/openmrs, work, temp, logs?)
  e. Copy software to tomcat
  f. Source database
  g. Start tomcat 
   