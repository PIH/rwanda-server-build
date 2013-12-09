#!/bin/bash

# Create all the staging server directories for openmrs
# -- openmrs war
# -- openmrs modules
# -- openmrs databases

set -e

case $1 in
	rwink | butaro ) echo "Creating $HOME/staging/$1 directory";;

	malawi ) 	echo "$1 configuration is incomplete, but rwanda works ;)"
			 	exit 1 ;;

	* )  		echo "Usage: $0 rwink|butaro|malawi"
		 		exit 1
esac

#echo 'Run this as the tomcat6 user'
echo "This staging area is created by $(whoami) user"
mkdir $HOME/staging
cd $HOME/staging
echo "  in $(pwd) directory"
echo ''
mkdir $STAGING_HOME
cd $STAGING_HOME

echo 'Create warfile directory for production and dev/test'
mkdir warfile

echo 'Create modules directories'
mkdir modules/
mkdir modules/production
mkdir modules/dev

echo 'Create database directories'
mkdir database
mkdir database/production
mkdir database/de-identified
mkdir database/de-id-and-trim