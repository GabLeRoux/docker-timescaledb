#!/usr/bin/env bash

set -ex

docker build . -f latest-pg11.Dockerfile -t gableroux/timescaledb:latest-pg11
docker build . -f latest-pg12.Dockerfile -t gableroux/timescaledb:latest-pg12

docker push gableroux/timescaledb:latest-pg11
docker push gableroux/timescaledb:latest-pg12
