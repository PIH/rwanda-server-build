#!/bin/bash

# Update database exporter package
cd $HOME/Workspace/database-exporter
git pull --rebase

# Build the databaseexporter executables including jar file
mvn clean package -DskipTests

# Copy jar file to $HOME/staging/bin directory
cp target/databaseexporter-*-jar-with-dependencies.jar $HOME/staging/bin/db-exporter.jar

exit 0
