#!/bin/bash

# params
SERVICENAME="ntp"
IMAGENAME="apnex/control-ntp"
DOCKER_OPTS="--cap-add SYS_NICE --cap-add SYS_RESOURCE --cap-add SYS_TIME"

# launch & persist
docker rm -v $(docker ps -qa -f name="${SERVICENAME}" -f status=exited) 2>/dev/null
RUNNING=$(docker ps -q -f name="${SERVICENAME}")
if [[ -z "$RUNNING" ]]; then
	printf "[${IMAGENAME}] not running - now starting\n" 1>&2
	docker run -d				\
		--name=${SERVICENAME}		\
		-p 123:123/udp			\
		${DOCKER_OPTS}			\
	${IMAGENAME}
fi
