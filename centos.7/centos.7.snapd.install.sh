#!/bin/bash
yum install -y epel-release
yum install -y snapd
systemctl start snapd
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap
exec bash
