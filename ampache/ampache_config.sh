#!/bin/bash
chown www-data:www-data /var/www/config1/
cp -a /var/www/config/. /var/www/config1
cd /var/www/config1/
sed \
    -e 's/\(database_hostname = \)localhost/\1'$AMPACHE_DB_HOSTNAME'/' \
    -e 's/\(database_username = \)username/\1'$AMPACHE_DB_USERNAME'/' \
    -e 's/\(database_password = \)password/\1'$AMPACHE_DB_PASSWORD'/' \
    -e 's/\(secret_key = \)"abcdefghijklmnoprqstuvwyz0123456"/\1"'$AMPACHE_SECRET_KEY'"/' \
    -e 's/;\(waveform = \)"false"/\1"true"/' \
    -e 's/;\(generate_video_preview = "true"\)/\1/' \
    -e 's/;\(licensing = "false"\)/\1/' \
    -e 's/;\(allow_public_registration = "false"\)/\1/' \
    -e 's/;\(cookie_disclaimer = "false"\)/\1/' \
    -e 's/;\(transcode_m4a[[:blank:]]\+= \)allowed/\1required/' \
    -e 's/;\(transcode_flac[[:blank:]]\+= required\)/\1/' \
    -e 's/;\(transcode_mpc[[:blank:]]\+= required\)/\1/' \
    -e 's/;\(transcode_ogg[[:blank:]]\+= \)required/\1allowed/' \
    -e 's/;\(transcode_wav[[:blank:]]\+= required\)/\1/' \
    -e 's/;\(transcode_avi[[:blank:]]\+= allowed\)/\1/' \
    -e 's/;\(transcode_mkv[[:blank:]]\+= allowed\)/\1/' \
    -e 's/;\(transcode_mpg[[:blank:]]\+= allowed\)/\1/' \
    -e 's/;\(encode_target = mp3\)/\1/' \
    -e 's/;\(encode_video_target = webm\)/\1/' \
    -e 's/;\(transcode_cmd = "avconv"\)/\1/' \
    < ampache.cfg.php.dist \
    > ampache.cfg.php
chown www-data:www-data ampache.cfg.php
chmod 664 ampache.cfg.php
cd /var/www/sql/
sed -i \
    's/@db_name/'$AMPACHE_DB_NAME'/g' \
    001_create_db.sql
sed -i \
    's/@db_name/'$AMPACHE_DB_NAME'/g;s/@usr_name/'$AMPACHE_DB_USERNAME'/g;s/@usr_passwd/'$AMPACHE_DB_PASSWORD'/g' \
    002_create_usr.sql
# mysql -h$AMPACHE_DB_HOSTNAME -uroot -p$AMPACHE_DB_ROOT_PASSWORD -e"source 001_create_db.sql"
