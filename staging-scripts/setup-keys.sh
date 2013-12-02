#!/bin/bash
# Password-less file transfer

set -e

case $1 in
	rwanda )	source ../conf/$1.sh;;
	malawi ) 	echo "$1 configuration is incomplete"
			 	exit 1 ;;
	* )  		echo "Usage: $0 rwanda|malawi"
		 		exit 1
esac

echo ''
echo "Password-less access is needed for user $REMOTE_USER_NAME on these servers:"
echo "  war:  $PROD_WAR_SERVER"
echo "  omod: $PROD_OMOD_SERVER"
echo "  db1:  $PROD_DB_SERVER1"
echo "  db2:  $PROD_DB_SERVER2"
echo ''
echo 'Generate the key locally with this command: ssh-keygen -t dsa'

echo ''
echo '** For Server #1 **'
echo "  scp -P $PROD_DB_SERVER1_PORT id_dsa.pub $REMOTE_USER_NAME@$PROD_DB_SERVER1:public.key"
echo "  ssh -p $PROD_DB_SERVER1_PORT $REMOTE_USER_NAME@$PROD_DB_SERVER1"
echo '  mkdir .ssh'
echo '  cat public.key >> .ssh/authorized_keys2'
echo '  chmod 600 .ssh/authorized_keys2'

echo ''
echo '** For Server #2 **'
echo "  scp -P $PROD_DB_SERVER2_PORT id_dsa.pub $REMOTE_USER_NAME@$PROD_DB_SERVER2:public.key"
echo "  ssh -p $PROD_DB_SERVER2_PORT $REMOTE_USER_NAME@$PROD_DB_SERVER2"
echo '  mkdir .ssh'
echo '  cat public.key >> .ssh/authorized_keys2'
echo '  chmod 600 .ssh/authorized_keys2'