#!/bin/bash
yum install epel-release
yum install snapd
systemctl start snapd
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap
exec bash
