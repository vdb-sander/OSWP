#!/bin/bash

############# Configuration constants ###########
 
LOGS_PATH="logs/$(date '+%Y-%m-%d_%H-%M')"
 
OUTPUT_INTERFACE="eth0"
INPUT_INTERFACE="wlan0"
HOSTAPD_CONF="configs/WPA.conf"
DNSMASQ_CONF="configs/dnsmasq.conf"

###############################################

if [ "$1" == "stop" ];then
	echo "Enabling NetworkManager..."
	service NetworkManager start

	echo "Killing hostapd..."
	pkill hostapd
	sleep 3;

	echo "Killing dnsmasq..."
	service dnsmasq stop
	sleep 3;

	echo "Flushing iptables"
	iptables --flush
	iptables --table nat --flush
	iptables --delete-chain
	iptables --table nat --delete-chain

	echo "Disabling IP Forwarding"
	echo "0" > /proc/sys/net/ipv4/ip_forward

elif [ "$1" == "start" ]
then
	echo "Tools output stored in ${LOGS_PATH}"

	mkdir -p "${LOGS_PATH}"

	echo "Configuring interface wlan0 according to dnsmasq config"
	ifconfig wlan0 up
	ifconfig wlan0 192.168.10.1 netmask 255.255.255.0
	
	echo "Configuring iptables"
	iptables -t nat -A  POSTROUTING -o $OUTPUT_INTERFACE -j MASQUERADE

	echo "Enable IP Forwarding"
	echo "1" > /proc/sys/net/ipv4/ip_forward

	echo "Killing NetworkManager..."
        service NetworkManager stop
	echo "nameserver 8.8.8.8" > /etc/resolv.conf

	echo "Starting Fake AP..."
	hostapd $HOSTAPD_CONF | tee $LOGS_PATH/hostapd.log &
	service dnsmasq start 

else
	echo "usage: ./rogueAP.sh stop|start"
fi
