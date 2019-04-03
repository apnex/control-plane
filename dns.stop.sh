#!/bin/bash

SERVICENAME="bind-cli"

printf "[apnex/${SERVICENAME}] stopping\n" 1>&2
docker rm -f "dns" 2>/dev/null

# remove dangling image
docker rm -v $(docker ps -qa -f name="dns" -f status=exited) 2>/dev/null
