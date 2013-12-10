#!/bin/bash
# Password-less file transfer

set -e

case $1 in
	rwink | butaro | rwink-local | butaro-local ) 
					source $HOME/.envStaging/$1.conf;;

	malawi | neno )	echo "$1 configuration is incomplete, but rwanda works ;)"
			 		exit 1 ;;

	* )  			echo "Usage: $0 rwink|butaro|rwink-local|butaro-local|malawi"
		 			exit 1
esac

echo ''
echo "Password-less access is needed for user $REMOTE_USER_NAME on these servers:"
echo "  war:	$PROD_WAR_SERVER"
echo "  omod:	$PROD_OMOD_SERVER"
echo "  db: 	$PROD_DB_SERVER"
echo ''
echo 'Generate the local RSA key with this command: ssh-keygen -t rsa'
echo ''
echo "Transfer client key to war server ($PROD_WAR_SERVER)"
echo "  ssh-copy-id $REMOTE_USER_NAME@$PROD_WAR_SERVER -p $PROD_WAR_PORT"
echo ''
echo "Transfer client key to omod server ($PROD_OMOD_SERVER)"
echo "  ssh-copy-id $REMOTE_USER_NAME@$PROD_OMOD_SERVER -p $PROD_OMOD_PORT"
echo ''
echo "Transfer client key to DB Server ($PROD_DB_SERVER)"
echo "  ssh-copy-id $REMOTE_USER_NAME@$PROD_DB_SERVER -p $PROD_DB_SERVER_PORT"
