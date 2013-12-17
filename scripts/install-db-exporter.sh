#!/bin/bash

# Install database exporter package

# Get software package from github
cd $HOME/Workspace
git clone https://github.com/PIH/openmrs-contrib-databaseexporter database-exporter

# Build the databaseexporter executables including jar file
cd database-exporter
mvn clean package -DskipTests

# Copy jar file to $HOME/staging/bin directory
cp target/databaseexporter-*-jar-with-dependencies.jar $HOME/staging/bin/db-exporter.jar

exit 0