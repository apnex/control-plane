#!/bin/bash
echo "-- shutting down running containers --"
docker rm -f -v $(docker ps -q) 2>/dev/null
echo "-- removing untagged containers --"
docker rmi -f $(docker images -q --filter dangling=true) 2>/dev/null
echo "-- removing orphaned volumes --"
docker rm -f $(docker ps -qa -f status=exited) 2>/dev/null

echo "-- starting constellation --"
docker run -d -P --net host --restart=unless-stopped \
	-v ${PWD}/zones.json:/root/zones.json \
	-v ${PWD}/dns.entrypoint.sh:/root/start.sh \
	--name dns apnex/control-dns
docker ps
