#!/bin/sh

/usr/local/etc/rc.d/transmission stop
python2.7 fix_ip.py "/usr/pbi/transmission-amd64/etc/transmission/home/settings.json" "$4"
/usr/local/libexec/openvpn-client.up $1 $2 $3 $4 $5 $6
/usr/local/etc/rc.d/transmission start
