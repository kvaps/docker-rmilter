#!/bin/bash

dir=(
    /etc/rmilter
    /var/lib/rmilter
    /var/log/messages
    /var/log/maillog
)

move_dirs()
{
    echo "info:  start moving lib and log folders to /data volume"

    mkdir -p /data/etc
    mkdir -p /data/var/lib
    mkdir -p /data/var/log

    for i in "${dir[@]}"; do mv $i /data$i; done

    echo "info:  finished moving lib and log folders to /data volume"
}

link_dirs()
{
    echo "info:  start linking default lib and log folders to /data volume"

    for i in "${dir[@]}"; do rm -rf $i && ln -s /data$i $i ; done
 
    echo "info:  finished linking default lib and log folders to /data volume"
}
run()
{ 
    rsyslogd
    tail -f -n 0 /var/log/maillog &
    rmilter -n -c /etc/rmilter/rmilter.conf
}

if [ ! -d /data/etc ] ; then
    move_dirs
    link_dirs
    run
else
    link_dirs
    run
fi
