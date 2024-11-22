#!/bin/bash

# Function to add or update a hostname in /etc/dyndnshosts
add_update_hostname() {
    ip="$1"
    hostname="$2"
    
    # Replace the old IP with the new one if the hostname exists
    if grep -q " $hostname$" /etc/dyndnshosts; then
        sed -i "s/^[0-9.]* $hostname$/$ip $hostname/" /etc/dyndnshosts
    else
        echo "$ip $hostname" >> /etc/dyndnshosts
    fi
}

# Function to reload dnsmasq
reload_dnsmasq() {
    systemctl reload dnsmasq
}

# Main script
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <ipv4> <hostname>"
    exit 1
fi

ip="$1"
hostname="$2"

add_update_hostname "$ip" "$hostname"
reload_dnsmasq

echo "Hostname '$hostname' with IP '$ip' added/updated in /etc/dyndnshosts and dnsmasq reloaded."
