#!/bin/bash

log=/var/log/rmilter/rmilter.log

trap '{
    echo "stoping rmilter"
    pkill rmilter
    exit 0
}' EXIT

echo "starting rsyslog"
/sbin/rsyslogd
echo "starting rmilter"
/sbin/runuser _rmilter -c "/sbin/rmilter -c /etc/rmilter.conf"
tail -f -n1 /var/log/maillog
