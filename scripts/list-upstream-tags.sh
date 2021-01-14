#!/usr/bin/env bash

docker run --rm quay.io/skopeo/stable \
    --override-os linux \
    inspect docker://timescale/timescaledb:latest-pg12 \
    | jq '.RepoTags[]' -r

