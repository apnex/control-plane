#!/bin/bash

# create cache and start squid
if [ ! -d ./cache ]; then
	mkdir cache
fi

## build auth file.
printf "buster:$(openssl passwd -crypt 'test')\n" | sudo tee -a ${PWD}/htpasswd

# launch & persist
docker rm -v $(docker ps -qa -f name=squid -f status=exited) 2>/dev/null
RUNNING=$(docker ps -q -f name="squid")
if [[ -z "$RUNNING" ]]; then
	printf "[apnex/squid] not running - now starting\n" 1>&2
	# -p 3128:3128
	docker run --name squid -d --net host \
		-v ${PWD}/squid.entrypoint.sh:/sbin/entrypoint.sh \
		-v ${PWD}/squid.auth:/etc/squid3/squid.conf \
		-v ${PWD}/htpasswd:/etc/squid3/htpasswd \
		-v ${PWD}/cache:/var/spool/squid3 \
	apnex/control-squid
	#./squid.redirect.enable.sh
fi

