#!/usr/bin/env bash
set -ex
source /docker-entrypoint.sh

if [[ -n "$POSTGRES_PORT" ]]; then
  POSTGRES_CONFIGURATION_FILE=$PGDATA/postgresql.conf
  POSTGRES_CONFIGURATION_MARKER="## PostgreSQL port configuration"
  echo "Configuring PostgreSQL port"

  if grep -Fxq "$POSTGRES_CONFIGURATION_MARKER" $POSTGRES_CONFIGURATION_FILE
  then
    # configuration file already written
    echo "Postgresql port already written, skipping"
  else
    # write configuration file
    docker_temp_server_stop
    echo "Postgresql configuration port update being written: $POSTGRES_PORT"
    echo "$POSTGRES_CONFIGURATION_MARKER" >> $POSTGRES_CONFIGURATION_FILE
    echo "port = $POSTGRES_PORT" >> $POSTGRES_CONFIGURATION_FILE
    docker_temp_server_start
  fi
fi
