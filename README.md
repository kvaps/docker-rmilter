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
    --link redis:redis
    -p 11332:11332 \
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
    - redis:redis
  ports:
    - 11332:11332
  volumes:
    - /etc/localtime:/etc/localtime:ro
    - ./rmilter:/data
```
