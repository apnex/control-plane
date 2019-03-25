#!/bin/bash
echo "-- shutting down running containers --"
docker rm -f -v $(docker ps -q) 2>/dev/null
echo "-- removing untagged containers --"
docker rmi -f $(docker images -q --filter dangling=true) 2>/dev/null
echo "-- removing orphaned volumes --"
docker rm -f $(docker ps -qa -f status=exited) 2>/dev/null

echo "-- starting constellation --"
# start dns
./bind-cli.start.sh

# start squid
./squid.start.sh

# start pxe
./pxe.start.sh

# start node-esx
#docker run -d -p 5081:80 --name node-esx apnex/node-esx
#docker run -d -p 5082:80 --name node-centos apnex/node-centos

docker ps
