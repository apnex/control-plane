#!/bin/bash

# remove existing docker
dnf remove \
	docker \
	docker-ce \
	docker-client \
	docker-client-latest \
	docker-common \
	docker-latest \
	docker-latest-logrotate \
	docker-logrotate \
	docker-selinux \
	docker-engine-selinux \
	docker-engine

## add fedora repo
dnf -y install dnf-plugins-core
dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

# install latest stable docker
dnf install -y \
	docker-ce \
	docker-ce-cli \
	containerd.io \

# start docker and enable on-boot
systemctl enable docker
systemctl start docker
