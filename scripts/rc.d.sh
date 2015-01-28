#!/bin/sh

. /etc/rc.subr

name="transmissionvpn"
start_cmd="${name}_start"
stop_cmd="${name}_stop"

transmissionvpn_start()
{
    /FreeNAS-Transmission-OpenVPN/run.sh
}

transmissionvpn_stop()
{
    /FreeNAS-Transmission-OpenVPN/stop.sh
}


load_rc_config $name
run_rc_command "$1"
