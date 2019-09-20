#!/bin/bash
echo "-- shutting down running containers --"
docker rm -f -v $(docker ps -q) 2>/dev/null
echo "-- removing untagged containers --"
docker rmi -f $(docker images -q --filter dangling=true) 2>/dev/null
echo "-- removing orphaned volumes --"
docker rm -f $(docker ps -qa -f status=exited) 2>/dev/null

echo "-- starting constellation --"
# start dns
touch /etc/resolv.conf
docker run -d -P --net host --restart=unless-stopped \
	-v ${PWD}/custom.records.json:/usr/lib/node_modules/bind-cli/lib/records.json \
	--name dns \
apnex/bind-cli

# start squid
./squid.start.sh

# start pxe
docker run -d -P --net host \
	-v ${PWD}/dhcpd.conf:/etc/dhcpd.conf \
	--name pxe \
apnex/control-pxe

# start node-esx
./esx.start.sh

# start node-centos
./centos.start.sh

# start ntp
./ntp.start.sh

docker ps
