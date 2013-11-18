rwanda-server-build
===================

Build scripts for Rwanda IMB servers (reporting, test, demo, dev, etc)

1. Get latest version of OpenMRS database.  Do we trim database nightly or on demand?  (de-identified, trimmed, metadata only)
2. Get latest version of OpenMRS software (war and modules)
3. Stop tomcat 
4. Cleanup tomcat directories (webapps/openmrs, work, temp, logs?)
5. Copy software to tomcat
6. Source database
7. Start tomcat

Setup steps

1. Password-less file transfer
2. Recovery from incomplete builds
