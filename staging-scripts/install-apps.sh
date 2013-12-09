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

apt-get install git maven p7zip-full openjdk-6-jdk
