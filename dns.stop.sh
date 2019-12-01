#!/bin/bash

SERVICENAME="dns"
IMAGENAME="control-dns"

printf "[apnex/${IMAGENAME}] stopping\n" 1>&2
docker rm -f "${SERVICENAME}" 2>/dev/null

# remove dangling image
docker rm -v $(docker ps -qa -f name="${IMAGENAME}" -f status=exited) 2>/dev/null
