#!/bin/bash

SERVICENAME="esx"
IMAGENAME="control-esx"

# launch & persist
docker rm -v $(docker ps -qa -f name="${SERVICENAME}" -f status=exited) 2>/dev/null
RUNNING=$(docker ps -q -f name="${SERVICENAME}")
if [[ -z "$RUNNING" ]]; then
	printf "[apnex/${IMAGENAME}] not running - now starting\n" 1>&2
	docker run -d -p 5081:80 \
		--name "${SERVICENAME}" \
	apnex/"${IMAGENAME}"
fi
