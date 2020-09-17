#!/usr/bin/env bash

set -e


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
    su postgres pg_ctl -D "$PGDATA" -m fast -w stop
    echo "Postgresql configuration port update being written: $POSTGRES_PORT"
    echo "$POSTGRES_CONFIGURATION_MARKER" >> $POSTGRES_CONFIGURATION_FILE
    echo "port = $POSTGRES_PORT" >> $POSTGRES_CONFIGURATION_FILE

    su postgres pg_ctl -D "$PGDATA" -w start
  fi
fi
