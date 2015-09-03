Rspamd in a Docker container
============================

Run
---

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

Systemd unit
------------

Example of systemd unit: `/etc/systemd/system/rmilter.service`

```bash
[Unit]
Description=rmilter
After=docker.service
Requires=docker.service rspamd.service clamd.service

[Service]
Restart=always
ExecStart=/usr/bin/docker run --name rmilter -h rmilter --link rspamd:rspamd --link clamd:clamd -v /opt/rmilter:/data -p 11339:11339 kvaps/rmilter
ExecStop=/usr/bin/docker stop -t 5 rmilter ; /usr/bin/docker rm -f rmilter

[Install]
WantedBy=multi-user.target
```
