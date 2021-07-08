#!/bin/bash

ether=$(echo -e "$(/usr/sbin/ifconfig eth0 2>/dev/null| grep "inet " | awk '{print $2}')")
echo -n "$ether"|xclip -sel clipboard
