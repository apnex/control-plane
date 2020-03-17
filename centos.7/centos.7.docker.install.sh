#!/bin/bash

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

# install pre-requisites
yum install -y \
	yum-utils \
	device-mapper-persistent-data \
	lvm2

# add docker-ce repository
yum-config-manager \
	--add-repo \
	https://download.docker.com/linux/centos/docker-ce.repo

# install latest stable docker
yum install -y \
	docker-ce \
	docker-ce-cli \
	containerd.io \

# start docker and enable on-boot
systemctl enable docker
systemctl start docker
