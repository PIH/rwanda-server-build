#!/bin/bash

# Install pre-requisite software:
#
#	git
#	maven
#	7zip
#	java 6 jdk

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#apt-get install git maven p7zip-full openjdk-6-jdk

# Loop thru users who are defined in a configuration file
source /home/ball/.envStaging/usernames.conf

for user in $USERLIST
do
	useradd $user -s /bin/bash -m -p `openssl passwd $TEMP_PASSWD` -G sudo 
done

