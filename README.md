Rspamd in a Docker container
============================

Run
---

```bash
docker run \
    --name rmilter \
    -h rmilter \
    -v /opt/rmilter:/data:rw \
    --link rspamd:rspamd
    --link clamd:clamd
    -p 11339:11339 \
    -d \
    kvaps/rmilter
```
`--link` option need to connect another docker container *(e.g. rspamd and clamd)*
