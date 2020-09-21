FROM timescale/timescaledb:latest-pg11

COPY postgres-port-config.sh /docker-entrypoint-initdb.d
RUN chmod +x /docker-entrypoint-initdb.d/postgres-port-config.sh
