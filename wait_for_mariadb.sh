#!/bin/bash
# wait-for-postgres.sh

# set -e

host="$1"
shift
cmd="$@"

until  [[ $(docker inspect -f '{{json .State.Health.Status}}' ampache_mariadb1) == '"healthy"' ]]; do
    >&2 echo "mariadb is unavailable - sleeping"
    sleep 5
done

>&2 echo "mariadb is up - executing command"
# exec $cmd
echo $cmd
