Rspamd in a Docker container
============================

Quick start
-----------

**run command**

```bash
docker run \
    --name rmilter \
    -h rmilter \
    -v /opt/rmilter:/data:rw \
    --link rspamd:rspamd \
    --link clamd:clamd \
    -p 11339:11339 \
    -d \
    kvaps/rmilter
```
`--link` option need to connect another docker container *(e.g. rspamd and clamd)*

Docker-compose
--------------

**docker-compose.yml**

```yaml
rmilter:
  restart: always
  image: kvaps/rmilter
  hostname: rmilter
  links:
    - rspamd:rspamd
    - clamd:clamd
  ports:
    - 11339:11339
  volumes:
    - /etc/localtime:/etc/localtime:ro
    - ./rmilter:/data
```
