#!/bin/bash
docker-compose build
docker-compose up -d
# bash wait_for_mariadb.sh 1 2 3 4 5
docker exec -it ampache_config1 bash /root/ampache_config.sh
# docker-compose down
