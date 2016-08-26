FROM registry.access.redhat.com/rhel7

MAINTAINER jim@midnightfreddie.com

RUN yum -y install epel-release \
  && yum -y install nginx \
  && yum -y clean all

# VOLUME /srv/www

COPY www /srv/www

EXPOSE 80

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-c","/srv/www/nginx.conf"]
