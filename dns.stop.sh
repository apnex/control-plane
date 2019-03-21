#!/bin/bash

# stop container
printf "[apnex/dns] stopping\n" 1>&2
docker rm -f dns 2>/dev/null

# cleanup
docker rm -v $(docker ps -qa -f name=dns -f status=exited) 2>/dev/null
