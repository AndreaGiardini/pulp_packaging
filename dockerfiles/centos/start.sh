#!/usr/bin/env bash

# the "docker root" as I'm calling it, which is where all shared and persistent
# storage is located for the pulp containers.
DROOT=$1

if [ -z $DROOT ]
then
    echo "specify a directory in which to store data" 1>&2
    exit 1
fi

if [ ! -d $DROOT ]
then
    echo "specified path is not a directory" 1>&2
    exit 1
fi


echo Launching in $DROOT


if [ ! -d $DROOT/etc/pulp ]
then
    echo creating /etc/pulp
    mkdir -p $DROOT/etc/pulp
fi

if [ ! -d $DROOT/etc/pki/pulp ]
then
    echo creating /etc/pki/pulp
    mkdir -p $DROOT/etc/pki/pulp
fi

if [ ! -d $DROOT/var/lib/pulp ]
then
    echo creating /var/lib/pulp
    mkdir -p $DROOT/var/lib/pulp
    chown apache $DROOT/var/lib/pulp
fi

LINKS="--link qpid:qpid --link db:db"
MOUNTS="-v $DROOT/etc/pulp:/etc/pulp -v $DROOT/etc/pki/pulp:/etc/pki/pulp -v $DROOT/var/lib/pulp:/var/lib/pulp -v /dev/log:/dev/log"

# try to start an existing one, and only run a new one if that fails
if docker start db 2> /dev/null
then
    echo db already exists
else
    echo running db
    docker run -d --name db -p 27017:27017 pulp/mongodb
fi

# try to start an existing one, and only run a new one if that fails
if docker start qpid 2> /dev/null
then
    echo qpid already exists
else
    echo running qpid
    docker run -d --name qpid -p 5672:5672 pulp/qpid
fi

docker run -it --rm $LINKS $MOUNTS --hostname pulpapi pulp/centosbase bash -c /setup.sh

docker run $MOUNTS $LINKS -d --name beat pulp/worker beat
docker run $MOUNTS $LINKS -d --name resource_manager pulp/worker resource_manager
docker run $MOUNTS $LINKS -d --name worker1 pulp/worker worker 1
docker run $MOUNTS $LINKS -d --name worker2 pulp/worker worker 2
docker run $MOUNTS $LINKS -d --name pulpapi --hostname pulpapi -p 443:443 -p 80:80 pulp/apache
docker run $MOUNTS -d --name crane --hostname crane -p 5000:80 pulp/crane-allinone
