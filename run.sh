#!/bin/bash
docker-compose build
docker-compose up -d
exec wait_for_mariadb.sh
# docker exec -it ampache_config1 bash /root/ampache_config.sh
# docker-compose down
