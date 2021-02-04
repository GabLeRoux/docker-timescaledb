# docker-timescaledb

[![Docker Stars](https://img.shields.io/docker/stars/gableroux/timescaledb.svg)](https://hub.docker.com/r/gableroux/timescaledb)
[![Docker Pulls](https://img.shields.io/docker/pulls/gableroux/timescaledb.svg)](https://hub.docker.com/r/gableroux/timescaledb)
[![Docker Automated](https://img.shields.io/docker/automated/gableroux/timescaledb.svg)](https://hub.docker.com/r/gableroux/timescaledb)
[![Docker Build](https://img.shields.io/docker/build/gableroux/timescaledb.svg)](https://hub.docker.com/r/gableroux/timescaledb)
[![Image](https://images.microbadger.com/badges/image/gableroux/timescaledb.svg)](https://microbadger.com/images/gableroux/timescaledb)
[![Version](https://images.microbadger.com/badges/version/gableroux/timescaledb.svg)](https://microbadger.com/images/gableroux/timescaledb)
[![Layers](https://images.microbadger.com/badges/image/gableroux/timescaledb.svg)](https://microbadger.com/images/gableroux/timescaledb)

# ⚠️ You can use `$PGPORT` instead of `$POSTGRES_PORT` in `timescale/timescaledb` since `postgres` [added support here](https://github.com/docker-library/postgres/commit/89a2fb84e6ec42ecc04e195252e405c52ecd3a96) so don't use these images. 🎉

Timescaledb image with support for setting database port using `$POSTGRES_PORT` environment variable. Inspired by [following issue comment](https://github.com/docker-library/postgres/issues/196#issuecomment-252328796).

Issue was closed because they say all major CIs implements the `command` which also allows overriding the port. Well as of today (2020-09-21), Bitbucket Pipeline doesn't support that.

See [`./postgres-port-config.sh`](./postgres-port-config.sh) for more details.

## bitbucket-pipeline usage

Running two postgres (or timescaledb) services was impossible, but now it is:

```yaml
image: securecodebox/nmap

definitions:
  services:
    postgres:
      image: postgres:11.8
      environment:
        POSTGRES_DB: example
        POSTGRES_USER: example
        POSTGRES_PASSWORD: example_password
    timescaledb:
      image: gableroux/timescaledb:latest-pg12
      environment:
        POSTGRES_DB: example
        POSTGRES_USER: example
        POSTGRES_PASSWORD: example_password
        POSTGRES_PORT: 5452
steps:
    - step: &run-nmap
        name: nmap-postgresql
        services:
          - postgres
          - timescaledb
        script:
          - nmap -Pn localhost -p 5423
          - nmap -Pn localhost -p 5452

pipelines:
  branches:
    develop:
      - parallel:
        - step: *run-nmap
```

## build your own

1. list existing upstream image tags (you'll need `jq` installed)

```bash
./scripts/list-upstream-tags.sh
```

2. Build and publish your own

```bash
tag=latest-pg12
organization=gableroux
./scripts/build.sh $tag $organization
```

## License

[MIT](LICENSE.md) © [Gabriel Le Breton](https://gableroux.com)
