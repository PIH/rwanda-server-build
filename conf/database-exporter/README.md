Usage:
------

To run the database export tool, you would execute the following:

```java -jar databaseexporter-XYZ-jar-with-dependencies.jar <arguments>```

<arguments> should contain:
* The paths to the configuration files (see below), separated by spaces, to use for the given objective
* -url=<db_url> (eg. jdbc:mysql://localhost:3306/openmrs?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8)
* -user=<db_user>
* -password=<db_password>
* -targetDirectory=<output_dir> (if not supplied, defaults to current directory)

Typical configurations should be:

#### To export the full, de-identified database:

trimArchiveData.json

#### To export a de-identified database with a large subset of patients:

removeSyncData
rwanda/deidentify
rwanda/trimPatientsLarge
rwanda/trimArchiveData

#### To export a de-identified database with a small subset of patients:

removeSyncData
rwanda/deidentify
rwanda/trimPatientsSmall
rwanda/trimArchiveData

#### To export a database with all patients and nearly all users and providers removed:

removeSyncData
removeAllPatients
rwanda/deidentify
rwanda/trimUsers
rwanda/trimProviders
rwanda/trimArchiveData
