FROM centos:centos7
MAINTAINER Pulp Team <pulp-list@redhat.com>

ADD rhel-pulp.repo /etc/yum.repos.d/rhel-pulp.repo

RUN yum -y install http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-1.noarch.rpm

# workaround: python-pulp-rpm-common not installed by groupinstall
RUN  yum update -y && \
     yum groupinstall -y \
         pulp-admin && \
     yum install -y \
         pulp-docker-admin-extensions && \
     yum clean all

# config and uploads dir
VOLUME ["/.pulp /run/pulp_uploads"]

ADD admin.conf /.pulp/admin.conf
