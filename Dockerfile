FROM centos:centos6
MAINTAINER kvaps <kvapss@gmail.com>
ENV REFRESHED_AT 2015-09-17

RUN yum -y install epel-release

RUN yum -y install rsyslog git gcc cmake openssl-devel pcre-devel sendmail-devel bison flex

#Install Rmilter
RUN git clone https://github.com/vstakhov/rmilter /usr/src/rmilter
 
WORKDIR /usr/src/rmilter

RUN cmake -DCMAKE_INSTALL_PREFIX=  . 
RUN make -j2
RUN make install

RUN adduser --system --no-create-home _rmilter
#RUN cp /usr/src/rmilter/debian/rmilter.init /etc/init.d/rspamd
RUN mkdir -p /var/lib/rmilter /var/run/rmilter
RUN chown _rmilter:_rmilter /var/lib/rmilter /var/run/rmilter
ADD rmilter.conf /etc/rmilter.conf

ADD start.sh /bin/start.sh
ENTRYPOINT ["/bin/start.sh"]

# Attach data volume
VOLUME ["/data"]

EXPOSE 11339

WORKDIR /root

