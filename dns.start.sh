#!/bin/bash

SERVICENAME="bind-cli"

# launch & persist
docker rm -v $(docker ps -qa -f name=dns -f status=exited) 2>/dev/null
RUNNING=$(docker ps -q -f name=dns)
if [[ -z "$RUNNING" ]]; then
	touch /etc/resolv.conf
	printf "[apnex/${SERVICENAME}] not running - now starting\n" 1>&2
	docker run -d -P --net host --restart=unless-stopped \
		-v ${PWD}/records.json:/usr/lib/node_modules/bind-cli/lib/records.json \
		--name dns \
	apnex/"${SERVICENAME}"
fi
