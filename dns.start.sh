#!/bin/bash
if [[ $(readlink -f $0) =~ ^(.*)/([^/]+)$ ]]; then
	WORKDIR="${BASH_REMATCH[1]}"
	CALLED="${BASH_REMATCH[2]}"
fi

# parameters
SERVICENAME="dns"
IMAGENAME="control-dns"

# remove old instance
docker rm -v $(docker ps -qa -f name="${SERVICENAME}" -f status=exited) 2>/dev/null

# pre-requisites
function health {
	HEALTH=$(docker inspect --format='{{json .State.Health}}' dns | jq -r '."Status"')
	while [[ $HEALTH != "unhealthy" ]]; do
		printf "%s\n" "health: ${HEALTH}"
		sleep 2
		HEALTH=$(docker inspect --format='{{json .State.Health}}' dns | jq -r '."Status"')
	done
	printf "%s\n" "health: ${HEALTH}"
	case "${HEALTH}" in
		healthy)
			exit 0
		;;
		unhealthy)
			exit 1
		;;
		*)
			exit 0
		;;
	esac
}

# check if running
RUNNING=$(docker ps -q -f name="${SERVICENAME}")
if [[ -z "$RUNNING" ]]; then
	printf "[${SERVICENAME}] not running - now starting\n" 1>&2
	DOCKERRUN="docker run"
	if [[ $0 =~ ^[.] ]]; then # if local
		DOCKERRUN+=" -d"
	fi
	touch /etc/resolv.conf
	${DOCKERRUN} -d -P --net host \
		-v ${WORKDIR}/records.json:/usr/lib/node_modules/bind-cli/lib/records.json \
		--name "${SERVICENAME}" \
	apnex/"${IMAGENAME}"
	health
fi
