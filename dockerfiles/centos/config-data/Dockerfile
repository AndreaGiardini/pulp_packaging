FROM pulp/centosbase:latest
MAINTAINER Aaron Weitekamp <aweiteka@redhat.com>

VOLUME [ "/etc/pulp", "/var/www", "/var/lib/pulp" ]

ADD ./run.sh /run.sh

CMD [ "/run.sh" ]
