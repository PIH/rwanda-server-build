drop database if exists @db_name;

-- create new openmrs databases
create database @db_name
default character set utf8
default collate utf8_general_ci;

-- create openmrs user with access to the database
create user openmrs identified by 'foo';
grant all on @db_name.* TO 'openmrs'@'%';

use @db_name;

source openmrs.sql;

quit;