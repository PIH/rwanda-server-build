#!/bin/bash

set -e

case $1 in
	rwink | butaro | rwink-local | butaro-local )
					source $HOME/.envStaging/$1.conf
					source $HOME/.envStaging/staging.conf
					echo ""
					echo "Date: $(date)" 
					echo "Starting $0"
					echo "  Copying the latest $1 files to the staging server" ;;

	malawi ) 		echo "$1 configuration is incomplete"
			 		exit 1 ;;

	* )  			echo "Usage: $0 rwink|butaro|rwink-local|butaro-local|malawi"
		 			exit 1
esac

# The directories were created by the setup-folders.sh script
cd $STAGING_HOME

echo 'Clear out the timestamp'
rm -f LAST-UPDATE

# Check for memory leak
#free -m

# Copy production war file to staging
echo "Copy war file from $PROD_WAR_SERVER to staging server"
cd $STAGING_HOME/warfile
scp -P $PROD_WAR_PORT $REMOTE_USER_NAME@$PROD_WAR_SERVER:$PROD_WAR_FILE .

# Copy modules to staging
echo "Copy modules from $PROD_OMOD_SERVER:$PROD_OMOD_FILES to staging server"
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

# Create the $IMPLEMENTATION database
cd $STAGING_HOME/database/production
SQL_INIT=drop-and-create.sql
rm -f $SQL_INIT
ln -s $SOURCE_HOME/scripts/$SQL_INIT .

# Drop and create blank database with user
echo "Drop/create $IMPLEMENTATION database and grant user openmrs access"
mysql -u root -p$MYSQL_ROOT_PASSWD mysql -e "set @prod_db_name = '$IMPLEMENTATION'; set @myuser = '$MYSQL_USER'; set @passed = '$MYSQL_ROOT_PASSWD'; source $SQL_INIT;"

# Source the database on the staging server
echo "Source the production $IMPLEMENTATION database"
mysql -u $MYSQL_USER -p$MYSQL_ROOT_PASSWD $IMPLEMENTATION -e "source openmrs.sql;"

# 
DB_EXP_URL="jdbc:mysql://localhost:3306/$IMPLEMENTATION?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8"
DB_EXP_JAVA_PARAMS="$JAVA_PARA -jar $HOME/staging/bin/db-exporter.jar"
DB_EXP_PARAMS="$DB_EXP_JAVA_PARAMS -url=$DB_EXP_URL -user=$MYSQL_USER -password=$MYSQL_ROOT_PASSWD -configDir=$SOURCE_HOME/conf"

BUILD_DIR=$SOURCE_HOME/conf/database-exporter/builds/$COUNTRY

for bf in $BUILD_DIR/*.conf
do
  build=$(basename $bf)
  echo "Processing $build database..."
  TARGET_DIR=$STAGING_HOME/database/$(echo $build | cut -f1 -d'.')
  mkdir -p $TARGET_DIR

  # Run the database exporter
  DB_EXP_TARGET="-targetDirectory=$TARGET_DIR"
  source $bf
  java $DB_EXP_PARAMS $DB_EXP_TARGET $JSON_FILES

  # Clean up yesterdaty and move from output file to standard name
  cd $TARGET_DIR
  rm -f openmrs.*
  rm -f export_$(date --date="yesterday" +"%Y_%m_%d")*.log
  mv export_$(date +"%Y_%m_%d")*.sql openmrs.sql

  # Compress database.
  # Compared gzip, 7zip, and bzip2.  7zip compresses to the smallest, but bzip2 is only 
  # slightly larger and easier for users to decompress
  bzip2 -fk openmrs.sql 
done

# Show date/time of last update
echo 'Create the timestamp'
cd $STAGING_HOME
touch LAST-UPDATE
echo ''

exit 0