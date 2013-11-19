rwanda-server-build
===================

Build scripts for Rwanda IMB servers (reporting, test, demo, dev, etc)

Questions

1. Should we use puppet for building servers?  updating openmrs?  updating database? 
2. Do we trim database nightly or on demand?
3. How do we handle errors or recover from incomplete builds?

Steps

1. Get latest version of OpenMRS database -- de-identified, trimmed, metadata only
2. Get latest version of OpenMRS software (war and modules)
3. Stop tomcat 
4. Cleanup tomcat directories (webapps/openmrs, work, temp, logs?)
5. Copy software to tomcat
6. Source database
7. Start tomcat

Setup steps

1. Password-less file transfer
2. Recovery from incomplete builds
