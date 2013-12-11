-- Used these variables:
--   prod_db_name = $IMPLEMENTATION
--   myuser = $MYSQL_USER
--   passed = $MYSQL_ROOT_PASSWD

-- drop database if exists @prod_db_name;
set @drop_cmd = CONCAT('drop database if exists ', @prod_db_name);
prepare stmt from @drop_cmd;
execute stmt;
deallocate prepare stmt;

-- create new and empty openmrs database
set @create_cmd = CONCAT('create database ', @prod_db_name, ' default character set utf8 default collate utf8_general_ci');
prepare stmt from @create_cmd;
execute stmt;
deallocate prepare stmt;

-- create openmrs user with access to the database
set @grant_cmd = CONCAT('grant all on ', @prod_db_name, '.* TO \'',@myuser,'\'@\'localhost\' identified by \'',@passed,'\'');
prepare stmt from @grant_cmd;
execute stmt;
deallocate prepare stmt;
