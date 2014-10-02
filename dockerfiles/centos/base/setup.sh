#!/usr/bin/env bash

# copy the basic directory structure if it isn't already present.
if [ ! -e /var/lib/pulp/content ]
then
    cp -a /var/local/var_lib_pulp/* /var/lib/pulp/
fi
if [ ! -e /etc/pulp/server.conf ]
then
    cp -a /var/local/etc_pulp/* /etc/pulp/
fi
if [ ! -e /etc/pki/pulp/ca.crt ]
then
    cp -a /var/local/etc_pki_pulp/* /etc/pki/pulp/
fi

# a hacky way of waiting until mongo is done initializing itself. Eventually
# pulp-manage-db will do this on its own in a reasonable way. It waits
# currently, but quickly backs off to a poll interval of 32 seconds, which is
# undesirable.
until echo "" | nc db 27017 2>/dev/null
do
    echo "waiting for mongodb"
    sleep 1
done

runuser -u apache pulp-manage-db
