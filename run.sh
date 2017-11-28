#!/bin/bash
docker-compose build
docker-compose up -d
docker exec -it ampache_config1 bash /root/ampache_config.sh
docker-compose down
