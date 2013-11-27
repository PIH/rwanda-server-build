#!/bin/bash

echo 'Enter the command with one argument (rwanda|malawi)'

# Get/set all variables
source config-$1.sh


echo "Password-less access is needed for user $REMOTE_USER_NAME"
echo " on these servers:"
echo "     $PROD_WAR_SERVER $PROD_OMOD_SERVER $PROD_DB_SERVER1 and $PROD_DB_SERVER2"

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
scp -P $PROD_DB_SERVER1_PORT $REMOTE_USER_NAME@$PROD_DB_SERVER1:$PROD_DB_SERVER1_FILE server1/openmrs.tar.7z.
ln -s server1 $SERVER1

# Copy database from production server #2
echo "Copy current database from $PROD_DB_SERVER2 server"
scp -P $PROD_DB_SERVER2_PORT $REMOTE_USER_NAME@$PROD_DB_SERVER2:$PROD_DB_SERVER2_FILE server2/openmrs.tar.7z.
ln -s server2 $SERVER2

# Show date/time of last update
echo 'Create the timestamp'
cd $STAGING_HOME
touch LAST-UPDATE