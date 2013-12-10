#!/bin/bash

# Install pre-requisite software and Linux users.

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Install pre-requisite software:
#	git, maven, 7zip, and java 6 jdk packages
apt-get install git maven p7zip-full openjdk-6-jdk

# Get variables with usernames and a temporary password
source /home/ball/.envStaging/usernames.conf

# Create Linux usernames with temporary password
for user in $USERLIST
do
	useradd $user -s /bin/bash -m -p `openssl passwd $TEMP_PASSWD` -G sudo 
done

