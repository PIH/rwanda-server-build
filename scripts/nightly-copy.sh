#!/bin/bash

set -e

case $1 in
	rwink | butaro | rwink-local | butaro-local )		source $HOME/.envStaging/$1.conf;;

	malawi ) 		echo "$1 configuration is incomplete"
			 		exit 1 ;;

	* )  			echo "Usage: $0 rwink|butaro|rwink-local|butaro-local|malawi"
		 			exit 1
esac

# The directories were created by the setup-folders.sh script
cd $STAGING_HOME

echo 'Clear out the timestamp'
rm -f LAST-UPDATE

# Copy production war file to staging
echo "Copy war file from ${PROD_WAR_SERVER} to staging server"
cd $STAGING_HOME/warfile
scp -P $PROD_WAR_PORT $REMOTE_USER_NAME@$PROD_WAR_SERVER:$PROD_WAR_FILE .

# Copy modules to staging
echo "Copy modules from ${PROD_OMOD_SERVER}:${PROD_OMOD_FILES} to staging server"
cd $STAGING_HOME/modules/production
if [ -f "*.omod" ]
then
  rm -f *.omod
fi
scp -P $PROD_OMOD_PORT $REMOTE_USER_NAME@$PROD_OMOD_SERVER:$PROD_OMOD_FILES .

# Copy database from production server
echo "Copy current database from $PROD_DB_SERVER server"
cd $STAGING_HOME/database/production
rm -f openmrs.sql
scp -P $PROD_DB_SERVER_PORT $REMOTE_USER_NAME@$PROD_DB_SERVER:$PROD_DB_SERVER_FILE openmrs.tar.7z

# Unpack the databases
echo "Unpack the $PROD_DB_SERVER database"
7za x $PROD_DB_PASSWORD -so openmrs.tar.7z | tar xf -

# Show date/time of last update
echo 'Create the timestamp'
cd $STAGING_HOME
touch LAST-UPDATE