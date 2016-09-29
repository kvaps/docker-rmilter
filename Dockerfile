FROM centos:centos6
MAINTAINER kvaps <kvapss@gmail.com>
ENV REFRESHED_AT 2016-09-29

RUN yum -y install epel-release
RUN curl -o /etc/yum.repos.d/rspamd.repo http://rspamd.com/rpm-stable/centos-6/rspamd.repo
RUN rpm --import http://rspamd.com/rpm-stable/gpg.key
RUN yum -y install rmilter rsyslog

VOLUME ["/data"]
EXPOSE 11332
ENTRYPOINT ["/bin/start.sh"]

ADD start.sh /bin/start.sh
ADD rmilter.conf /etc/rmilter/rmilter.conf
