for NAME in beat resource_manager worker1 worker2 pulpapi crane
do
    echo stopping and removing $NAME
    docker stop $NAME > /dev/null
    docker rm $NAME > /dev/null
done
