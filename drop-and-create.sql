drop database if exists db1;

-- create new openmrs databases
create database db1
default character set utf8
default collate utf8_general_ci;

-- create openmrs user with access to the database
create user openmrs identified by 'foo';
grant all on db1.* TO 'openmrs'@'%';

use db1;

source trimmed_db.sql;

quit;