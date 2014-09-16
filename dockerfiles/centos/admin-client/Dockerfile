FROM centos:centos7
MAINTAINER Aaron Weitekamp <aweiteka@redhat.com>

ADD rhel-pulp.repo /etc/yum.repos.d/rhel-pulp.repo

RUN yum -y install http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-1.noarch.rpm

# workaround: python-pulp-rpm-common not installed by groupinstall
RUN  yum update -y && \
     yum groupinstall -y \
         pulp-admin && \
     yum install -y \
         python-pulp-rpm-common pulp-docker-admin-extensions && \
     yum clean all

# config and uploads dir
VOLUME ["/.pulp", "/run/pulp_uploads"]

ENTRYPOINT ["/usr/bin/pulp-admin"]
