FROM pulp/centosbase:latest
MAINTAINER Pulp Team <pulp-list@redhat.com>

ENV container docker

EXPOSE 443
EXPOSE 80

ADD docker.conf /etc/pulp/vhosts80/docker.conf
ADD run.sh /run.sh

CMD [ "/run.sh" ]
