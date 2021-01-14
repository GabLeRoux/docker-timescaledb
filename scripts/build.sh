#!/usr/bin/env bash

tag=${1:-latest-pg12}
repository=${2:-gableroux}

docker build . --build-arg "TAG=${tag}" -t gableroux/timescaledb:${tag}
docker push gableroux/timescaledb:${tag}

