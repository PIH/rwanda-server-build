#!/bin/bash

set -e

case $1 in
	rwanda )		source ../conf/$1.sh;;
	rwanda-local )	source ../conf/$1.sh;;
	malawi ) 		echo "$1 configuration is incomplete"
			 		exit 1 ;;
	* )  			echo "Usage: $0 rwanda|rwanda-local|malawi"
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

# Copy database from production server #1
echo "Copy current database from $PROD_DB_SERVER1 server"
cd $STAGING_HOME/database/production
scp -P $PROD_DB_SERVER1_PORT $REMOTE_USER_NAME@$PROD_DB_SERVER1:$PROD_DB_SERVER1_FILE server1/openmrs.tar.7z
ln -s server1 $SERVER1

# Copy database from production server #2
echo "Copy current database from $PROD_DB_SERVER2 server"
scp -P $PROD_DB_SERVER2_PORT $REMOTE_USER_NAME@$PROD_DB_SERVER2:$PROD_DB_SERVER2_FILE server2/openmrs.tar.7z
ln -s server2 $SERVER2

# Show date/time of last update
echo 'Create the timestamp'
cd $STAGING_HOME
touch LAST-UPDATE

# Unpack the databases
echo "Unpack the $PROD_DB_SERVER1 database"
cd server1
7za x $PROD_DB1_PASSWORD -so openmrs.tar.7z | tar xf -

echo "Unpack the $PROD_DB_SERVER2 database"
cd ../server2
7za x $PROD_DB2_PASSWORD -so openmrs.tar.7z | tar xf -
