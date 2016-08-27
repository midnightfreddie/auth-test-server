FROM registry.access.redhat.com/rhel7

MAINTAINER jim@midnightfreddie.com

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm \
  && rpm -ivh epel-release-7-8.noarch.rpm \
  && yum -y install epel-release 

RUN yum -y install nginx \
  && yum -y clean all

# VOLUME /srv/www

COPY www /srv/www

EXPOSE 80

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-c","/srv/www/nginx.conf"]
