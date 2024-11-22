#!/bin/bash

# List of IP addresses to ping
# 192.168.5.80  is my fast laptop 10.209.212.9 its vpn connection
# 192.168.5.5 is a always on machine
IP_STRING="192.168.5.80 10.209.212.9 192.168.5.5"

#set the wanted host name
hostname="whisper.dynhomelab"

# Function to check if IP is reachable
check_ip_reachable() {
    ip="$1"
    ping -c 1 -W 1 "$ip" >/dev/null 2>&1
}

# Main script
for ip in $IP_STRING; do
    if check_ip_reachable "$ip"; then
        echo "Found reachable IP: $ip"
        /usr/local/bin/dyndnsmasq.sh "$ip" "$hostname"
        exit 0
    fi
done

echo "No reachable IP found in the list."
exit 1
