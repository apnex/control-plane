#!/bin/bash

printf "[apnex/pxe] stopping\n" 1>&2
docker rm -f pxe 2>/dev/null

# remove dangling image
docker rm -v $(docker ps -qa -f name=pxe -f status=exited) 2>/dev/null
