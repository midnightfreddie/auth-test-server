FROM _/ubuntu:14.04

MAINTAINER jim@midnightfreddie.com

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get install -y nginx \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# VOLUME /srv/www

COPY www /srv/www

EXPOSE 80

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-c","/srv/www/nginx.conf"]
