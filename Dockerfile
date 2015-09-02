FROM centos:centos6
MAINTAINER kvaps <kvapss@gmail.com>
ENV REFRESHED_AT 2015-09-02

RUN mv /etc/localtime /etc/localtime.old; ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8; $(exit 0)
#RUN localedef -v -c -i ru_RU -f UTF-8 ru_RU.UTF-8; $(exit 0)
ENV LANG en_US.UTF-8

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

ADD rmilter-wrapper.sh /bin/rmilter-wrapper.sh
RUN chmod +x /bin/rmilter-wrapper.sh

ADD start.sh /bin/start.sh
ENTRYPOINT ["/bin/start.sh"]

# Attach data volume
VOLUME ["/data"]

EXPOSE 11339

WORKDIR /root

