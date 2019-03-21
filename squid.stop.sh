#!/bin/bash

printf "[apnex/squid] stopping\n" 1>&2
docker rm -f squid 2>/dev/null

# launch & persist
docker rm -v $(docker ps -qa -f name=squid -f status=exited) 2>/dev/null
