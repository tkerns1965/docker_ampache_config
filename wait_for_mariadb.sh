#!/bin/bash
# wait-for-postgres.sh

# set -e

host="$1"
shift
cmd="$@"

# until psql -h "$host" -U "postgres" -c '\q'; do
until  [[ $(docker inspect -f '{{json .State.Health.Status}}' ampache_mariadb1) == '"healthy"' ]]; do
    >&2 echo "Postgres is unavailable - sleeping"
    sleep 1
done

>&2 echo "Postgres is up - executing command"
# exec $cmd
echo $cmd
