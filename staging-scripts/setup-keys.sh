#!/bin/bash
# Password-less file transfer

set -e

case $1 in
	rwanda )	source ../conf/$1.sh;;
	malawi ) 	echo "$1 configuration is incomplete, but rwanda works ;)"
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
echo 'Generate the key locally with this command: ssh-keygen -t rsa'

echo ''
echo "Transfer client key to war server ($PROD_WAR_SERVER)"
echo "  ssh-copy-id $REMOTE_USER_NAME@$PROD_WAR_SERVER -p $PROD_WAR_PORT"
echo ''
echo "Transfer client key to omod server ($PROD_OMOD_SERVER)"
echo "  ssh-copy-id $REMOTE_USER_NAME@$PROD_OMOD_SERVER -p $PROD_OMOD_PORT"
echo ''
echo "Transfer client key to DB Server #1 ($PROD_DB_SERVER1)"
echo "  ssh-copy-id $REMOTE_USER_NAME@$PROD_DB_SERVER1 -p $PROD_DB_SERVER1_PORT"
echo ''
echo "Transfer client key to DB Server #2 ($PROD_DB_SERVER2)"
echo "  ssh-copy-id $REMOTE_USER_NAME@$PROD_DB_SERVER2 -p $PROD_DB_SERVER2_PORT"

#echo "  scp -P $PROD_DB_SERVER1_PORT .ssh/id_rsa.pub $REMOTE_USER_NAME@$PROD_DB_SERVER1:public.key"
#echo "  ssh -p $PROD_DB_SERVER1_PORT $REMOTE_USER_NAME@$PROD_DB_SERVER1"
#echo '  mkdir .ssh'
#echo '  cat public.key >> .ssh/authorized_keys2'
#echo '  chmod 600 .ssh/authorized_keys2'

#echo ''
#echo '** For Server #2 **'
#echo "  scp -P $PROD_DB_SERVER2_PORT .ssh/id_rsa.pub $REMOTE_USER_NAME@$PROD_DB_SERVER2:public.key"
#echo "  ssh -p $PROD_DB_SERVER2_PORT $REMOTE_USER_NAME@$PROD_DB_SERVER2"
#echo '  mkdir .ssh'
#echo '  cat public.key >> .ssh/authorized_keys2'
#echo '  chmod 600 .ssh/authorized_keys2'