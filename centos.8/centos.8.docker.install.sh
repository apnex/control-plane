#!/bin/bash

# remove existing docker
dnf remove -y \
	docker-ce \
	docker \
	docker-client \
	docker-client-latest \
	docker-common \
	docker-latest \
	docker-latest-logrotate \
	docker-logrotate \
	docker-engine

# install pre-requisites
dnf install -y \
	container-selinux

# add docker-ce repository
dnf config-manager \
	--add-repo \
	https://download.docker.com/linux/centos/docker-ce.repo

# install latest stable docker
dnf install -y --disablerepo=AppStream \
	docker-ce

# start docker and enable on-boot
systemctl enable docker
systemctl start docker
