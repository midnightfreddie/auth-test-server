FROM registry.access.redhat.com/rhel7

MAINTAINER jim@midnightfreddie.com

RUN yum install -y epel-release \
  && yum install -y nginx \
  && yum clean all

# VOLUME /srv/www

COPY www /srv/www

EXPOSE 80

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-c","/srv/www/nginx.conf"]
