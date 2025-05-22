#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-only

network() {
	dev=$(ip route | sed -n "1p")
	dev=${dev#*"dev "}
	dev=${dev%" proto"*}
	[ -z "$dev" ] && echo "?" && return

	link=$(cat /sys/class/net/$dev/carrier)
	[ $link -ne 1 ] && echo "?" && return

	type=$(cat /sys/class/net/$dev/type)
	if [ $type -eq 1 ]; then
		echo " "
	elif [ $type -eq 801 ]; then
		echo " "
	fi
}

cpu_usage() {
	load=$(awk '{print $1}' /proc/loadavg)
	echo  $(echo "$load*100/$(nproc)/1" | bc)%
}

mem_usage() {
	total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
	avail=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
	echo  $(echo "($total-$avail)*100/$total/1" | bc)%
}

case $1 in
time)
	date +%T
;;
cpu)
	cpu_usage
;;
mem)
	mem_usage
;;
net)
	network
;;
esac
