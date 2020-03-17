#!/bin/bash

# install
dnf install snapd
ln -s /var/lib/snapd/snap /snap
ls -l /snap

# start
systemctl start snapd
systemctl enable --now snapd.socket

