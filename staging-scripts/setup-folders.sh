#!/bin/bash

# Create all the staging server directories for openmrs
# -- openmrs war
# -- openmrs modules
# -- openmrs databases (server 1 and 2)

#echo 'Run this as the tomcat6 user'
echo "This staging area is created by $(whoami) user"
mkdir ${HOME}/staging
cd ${HOME}/staging
echo "  in $(pwd) directory"
echo ''

echo 'Create warfile directory for production and dev/test'
mkdir warfile

echo 'Create modules directories'
mkdir modules
mkdir modules/production
mkdir modules/dev

echo 'Create database directories'
mkdir database
mkdir database/production
mkdir database/production/server1
mkdir database/production/server2
mkdir database/de-identified
mkdir database/de-id-and-trim