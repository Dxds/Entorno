#!/bin/sh
 
IFACE=$(/usr/sbin/ifconfig | grep tun0 | awk '{print $2}' | tr -d ':')
echo -n "$IFACE"|xclip -sel clipboard 
