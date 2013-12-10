#!/bin/bash

set -e

case $1 in
	rwink | butaro | rwink-local | butaro-local )		source $HOME/.envStaging/$1.conf;;

	malawi ) 		echo "$1 configuration is incomplete"
			 		exit 1 ;;

	* )  			echo "Usage: $0 rwink|butaro|rwink-local|butaro-local|malawi"
		 			exit 1
esac

# Create the $IMPLEMENTATION database
cd $STAGING_HOME/database/production
mysql –uroot -p$MYSQL_ROOT_PASSWD -A -e "set @db_name=$IMPLEMENTATION; source drop-and-create.sql;"
