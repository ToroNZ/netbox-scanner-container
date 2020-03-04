#!/bin/ash

if [ "$(id -u)" -ne 1000 ]; then
    sed -e "s/^netbox:x:[^:]*:[^:]*:/netbox:x:$(id -u):$(id -g):/" /etc/passwd > /tmp/passwd
    cat /tmp/passwd > /etc/passwd
    rm /tmp/passwd
    export HOME=/home/netbox
fi

python netbox-scanner/nbscanner -p