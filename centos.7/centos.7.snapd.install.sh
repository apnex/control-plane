#yum install yum-plugin-copr epel-release
#yum copr enable ngompa/snapcore-el7
#yum install snapd
#systemctl start snapd
#systemctl enable --now snapd.socket
#export PATH=$PATH:/snap/bin
#snap alias microk8s.kubectl kubectl

yum install epel-release
yum install snapd
systemctl start snapd
systemctl enable --now snapd.socket

