#!/bin/bash

# create cache and start squid
if [ ! -d ./cache ]; then
	mkdir cache
fi

# launch & persist
docker rm -v $(docker ps -qa -f name=squid -f status=exited) 2>/dev/null
RUNNING=$(docker ps -q -f name="squid")
if [[ -z "$RUNNING" ]]; then
	printf "[apnex/squid] not running - now starting\n" 1>&2
	docker run --name squid -d -p 3128:3128 \
		-v ${PWD}/squid.entrypoint.sh:/sbin/entrypoint.sh \
		-v ${PWD}/squid.conf:/etc/squid3/squid.conf \
		-v ${PWD}/cache:/var/spool/squid3 \
	apnex/control-squid
fi
