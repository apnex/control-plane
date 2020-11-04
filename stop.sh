#!/bin/bash
echo "-- stopping constellation --"

./dns.stop.sh
./pxe.stop.sh
./ntp.stop.sh

echo "-- removing untagged containers --"
docker rmi -f $(docker images -q -f dangling=true) 2>/dev/null
