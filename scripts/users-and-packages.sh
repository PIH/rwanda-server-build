#!/bin/bash

# Install pre-requisite software and Linux users.

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Install pre-requisite software:
#	ssh, git, maven, 7zip, and java 6 jdk packages
PACKAGES="openssh-server git maven p7zip-full openjdk-6-jdk"
echo "Install Ubuntu debian packages"
for pkg in $PACKAGES
do
	echo "Install $pkg package"
	apt-get install $pkg
done

# Get variables with usernames and a temporary password
source /home/ball/.envStaging/users.conf

# Create Linux users with sudo permissions and temporary password
for user in $USERLIST
do
	echo "Create $user Linux user account, add to sudo group, and force password change"
	useradd $user -s /bin/bash -m -p `openssl passwd $TEMP_PASSWD` 
	usermod -a -G sudo $user 
	chage -d 0 $user
done

