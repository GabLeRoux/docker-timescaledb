ARG TAG=latest-pg12
FROM timescale/timescaledb:${TAG}

COPY postgres-port-config.sh /docker-entrypoint-initdb.d
RUN chmod +x /docker-entrypoint-initdb.d/postgres-port-config.sh
