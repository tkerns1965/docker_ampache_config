#!/bin/bash
# wait-for-postgres.sh

# set -e

host="$1"
shift
cmd="$@"

until mysql -h$AMPACHE_DB_HOSTNAME '\s'; do
    >&2 echo "mariadb is unavailable - sleeping"
    sleep 1
done

>&2 echo "mariadb is up - executing command"
# exec $cmd
echo $cmd
