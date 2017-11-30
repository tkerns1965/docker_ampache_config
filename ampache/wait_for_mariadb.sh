#!/bin/bash
# wait-for-postgres.sh

# set -e

host="$1"
shift
cmd="$@"

until mysql -h$AMPACHE_DB_HOSTNAME -p$AMPACHE_DB_ROOT_PASSWORD '\q'; do
    >&2 echo "mariadb is unavailable - sleeping"
    sleep 2
done

>&2 echo "mariadb is up - executing command"
# exec $cmd
echo $cmd
