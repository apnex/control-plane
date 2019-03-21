#!/bin/bash
echo "-- shutting down running containers --"
docker rm -f -v $(docker ps -q) 2>/dev/null
echo "-- removing untagged containers --"
docker rmi -f $(docker images -q --filter dangling=true) 2>/dev/null
echo "-- removing orphaned volumes --"
docker rm -f $(docker ps -qa -f status=exited) 2>/dev/null

echo "-- starting constellation --"
#docker run -d -P --net host --restart=unless-stopped \
#	-v ${PWD}/zones.json:/root/zones.json \
#	-v ${PWD}/dns.entrypoint.sh:/root/start.sh \
#	--name dns apnex/control-dns

# start dns
./bind-cli.start.sh

# start squid
./squid.start.sh

#docker run -d -P --net host \
#	--name pxe apnex/control-pxe
#docker run -d -p 5081:80 --name node-esx apnex/node-esx
#docker run -d -p 5082:80 --name node-centos apnex/node-centos
#docker run -d -p 3128:3128 \
#	-v ${PWD}/entrypoint.sh:/sbin/entrypoint.sh \
#	-v ${PWD}/squid.conf:/etc/squid3/squid.conf \
#	-v ${PWD}/cache:/var/spool/squid3 \
#	--name squid apnex/control-squid


docker ps
