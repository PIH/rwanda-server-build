#!/bin/bash

# Install database exporter package

# Get software package from github
cd $HOME/Workspace
git clone https://github.com/PIH/openmrs-contrib-databaseexporter database-exporter

# Build the databaseexporter executables including jar file
cd database-exporter
mvn clean package -DskipTests

# Copy jar file to $HOME/staging/bin directory
mkdir -f $HOME/staging
mkdir -f $HOME/staging/bin
cp target/databaseexporter-1.0-SNAPSHOT-jar-with-dependencies.jar $HOME/staging/bin/. 
