#!/bin/bash
chown www-data:www-data /var/www/config1/
cp -a /var/www/config/. /var/www/config1
cd /var/www/config1/
sudo -u www-data sed \
    -e 's/\(database_hostname = \)localhost/\1'$AMPACHE_DB_HOSTNAME'/p' \
    -e 's/\(database_username = \)username/\1'$AMPACHE_DB_USERNAME'/p' \
    -e 's/\(database_password = \)password/\1'$AMPACHE_DB_PASSWORD'/p' \
    -e 's/\(secret_key = \)"abcdefghijklmnoprqstuvwyz0123456"/\1"'$AMPACHE_SECRET_KEY'"/p' \
    -e 's/;\(waveform = \)"false"/\1"true"/p' \
    -e 's/;\(generate_video_preview = "true"\)/\1/p' \
    -e 's/;\(licensing = "false"\)/\1/p' \
    -e 's/;\(allow_public_registration = "false"\)/\1/p' \
    -e 's/;\(cookie_disclaimer = "false"\)/\1/p' \
    -e 's/;\(transcode_m4a[[:blank:]]\+= \)allowed/\1required/p' \
    -e 's/;\(transcode_flac[[:blank:]]\+= required\)/\1/p' \
    -e 's/;\(transcode_mpc[[:blank:]]\+= required\)/\1/p' \
    -e 's/;\(transcode_ogg[[:blank:]]\+= \)required/\1allowed/p' \
    -e 's/;\(transcode_wav[[:blank:]]\+= required\)/\1/p' \
    -e 's/;\(transcode_avi[[:blank:]]\+= allowed\)/\1/p' \
    -e 's/;\(transcode_mkv[[:blank:]]\+= allowed\)/\1/p' \
    -e 's/;\(transcode_mpg[[:blank:]]\+= allowed\)/\1/p' \
    -e 's/;\(encode_target = mp3\)/\1/p' \
    -e 's/;\(encode_video_target = webm\)/\1/p' \
    -e 's/;\(transcode_cmd = "avconv"\)/\1/p' \
    < ampache.cfg.php.dist \
    > ampache.cfg.php
