#!/bin/bash
touch /etc/resolv.conf

echo "-- starting constellation --"
docker run -d -P --net host --restart=unless-stopped \
	-v ${PWD}/records.json:/usr/lib/node_modules/bind-cli/lib/records.json \
	--name dns apnex/bind-cli
