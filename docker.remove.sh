#!/bin/bash

# stop docker and disable on-boot
systemctl disable docker
systemctl stop docker

# remove existing docker
yum remove \
	docker \
	docker-client \
	docker-client-latest \
	docker-common \
	docker-latest \
	docker-latest-logrotate \
	docker-logrotate \
	docker-engine

# remove docker
yum remove \
	docker-ce \
	docker-ce-cli \
	containerd.io

# disable docker-ce repository
yum-config-manager --disable \
	docker-ce
rm -f /etc/yum.repos.d/docker-ce.repo
