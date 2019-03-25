#!/bin/bash

# launch & persist
docker rm -v $(docker ps -qa -f name=pxe -f status=exited) 2>/dev/null
RUNNING=$(docker ps -q -f name="pxe")
if [[ -z "$RUNNING" ]]; then
	printf "[apnex/pxe] not running - now starting\n" 1>&2
	docker run -d -P --net host \
		--name pxe \
		apnex/control-pxe
fi
