FROM centos:centos7
MAINTAINER Aaron Weitekamp <aweiteka@redhat.com>

ADD rhel-pulp.repo /etc/yum.repos.d/rhel-pulp.repo

RUN yum -y install http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-1.noarch.rpm

RUN yum update -y && \
    yum groupinstall -y pulp-server pulp-docker-plugins && \
    yum clean all

RUN yum install -y git findutils && \
    yum clean all

# HACK: may not be needed
#RUN touch /etc/pulp/vhosts80/blank.conf
