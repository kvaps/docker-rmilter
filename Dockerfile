FROM centos:centos6
MAINTAINER kvaps <kvapss@gmail.com>
ENV REFRESHED_AT 2016-01-08

RUN yum -y install epel-release
RUN curl -o /etc/yum.repos.d/rspamd.repo http://rspamd.com/rpm-stable/centos-6/rspamd.repo
RUN rpm --import http://rspamd.com/rpm-stable/gpg.key
RUN yum -y install rmilter rsyslog
ADD rmilter.conf /etc/rmilter.conf

ADD start.sh /bin/start.sh
ENTRYPOINT ["/bin/start.sh"]

# Attach data volume
VOLUME ["/data"]

EXPOSE 11339

WORKDIR /root

