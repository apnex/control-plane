#!/bin/bash
echo "-- shutting down running containers --"
docker rm -f -v $(docker ps -q) 2>/dev/null
echo "-- removing untagged containers --"
docker rmi -f $(docker images -q --filter dangling=true) 2>/dev/null
echo "-- removing orphaned volumes --"
docker rm -f $(docker ps -qa -f status=exited) 2>/dev/null

echo "-- starting constellation --"
# start dns
./dns.start.sh

# start squid
./squid.start.sh

# start pxe
./pxe.start.sh

# start node-esx
./esx.start.sh

# start node-centos
./centos.start.sh

# start dns
./ntp.start.sh

docker ps
