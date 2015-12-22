#!/bin/sh

/usr/local/etc/rc.d/transmission stop
python2.7 fix_ip.py "/usr/pbi/transmission-amd64/etc/transmission/home/settings.json" "$4"
/usr/local/libexec/openvpn-client.up
/usr/local/etc/rc.d/transmission start
