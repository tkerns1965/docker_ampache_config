drop user if exists @usr_name;
create user if not exists @usr_name identified by @usr_passwd;
